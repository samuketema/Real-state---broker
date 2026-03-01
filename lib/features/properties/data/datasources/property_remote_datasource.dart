import 'package:realstate/core/error/exception.dart';
import 'package:realstate/features/properties/data/models/property_model.dart';
import 'package:realstate/features/properties/domain/entities/property_type.dart';
import 'package:realstate/features/properties/domain/entities/listing_type.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';

/// Remote data operations for `Property` objects.  All methods return raw
/// models and throw [ServerException] on failure so that callers can convert
/// the outcome to a [Failure] with the usual `Either` logic.
abstract interface class PropertyRemoteDatasource {
  Future<List<PropertyModel>> getAllProperties();
  Future<PropertyModel> getPropertyById(String id);
  Future<void> addProperty(PropertyModel property);
  Future<void> updateProperty(PropertyModel property);
  Future<void> deleteProperty(String id);

  /// Uploads local image paths to Supabase Storage and returns public URLs.
  Future<List<String>> uploadImages(List<String> localPaths, String propertyId);

  /// Search using optional filters; the default implementation in the
  /// concrete class simply applies the parameters to the Supabase query.
  Future<List<PropertyModel>> searchProperties({
    String? query,
    String? location,
    double? minPrice,
    double? maxPrice,
    int? bedrooms,
    int? bathrooms,
    PropertyType? type,
    ListingType? listingType,
  });
}

class PropertyRemoteDatasourceImpl implements PropertyRemoteDatasource {
  final SupabaseClient supabase;

  PropertyRemoteDatasourceImpl({required this.supabase});

  static const _table = 'properties';

  @override
  Future<void> addProperty(PropertyModel property) async {
    try {
      await supabase.from(_table).insert(property.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteProperty(String id) async {
    try {
      await supabase.from(_table).delete().eq('id', id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<PropertyModel>> getAllProperties() async {
    try {
      final res = await supabase.from(_table).select().order('created_at', ascending: false);
      return (res as List<dynamic>)
          .map((e) => PropertyModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<PropertyModel> getPropertyById(String id) async {
    try {
      final res = await supabase.from(_table).select().eq('id', id).single();
      return PropertyModel.fromJson(res as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<PropertyModel>> searchProperties({
    String? query,
    String? location,
    double? minPrice,
    double? maxPrice,
    int? bedrooms,
    int? bathrooms,
    PropertyType? type,
    ListingType? listingType,
  }) async {
    try {
      var request = supabase.from(_table).select();

      if (query != null && query.isNotEmpty) {
        request = request.ilike('title', '%$query%');
      }
      if (location != null && location.isNotEmpty) {
        request = request.ilike('location', '%$location%');
      }
      if (minPrice != null) {
        request = request.gte('price', minPrice);
      }
      if (maxPrice != null) {
        request = request.lte('price', maxPrice);
      }
      if (bedrooms != null) {
        request = request.eq('bedrooms', bedrooms);
      }
      if (bathrooms != null) {
        request = request.eq('bathrooms', bathrooms);
      }
      if (type != null) {
        request = request.eq('type', type.name);
      }
      if (listingType != null) {
        request = request.eq('listing_type', listingType.name);
      }

      final res = await request;
      return (res as List<dynamic>)
          .map((e) => PropertyModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateProperty(PropertyModel property) async {
    try {
      await supabase
          .from(_table)
          .update(property.toJson())
          .eq('id', property.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<String>> uploadImages(List<String> localPaths, String propertyId) async {
    const bucket = 'property-images';
    try {
      final uploaded = <String>[];

      for (final p in localPaths) {
        // If already a URL keep it
        if (p.toLowerCase().startsWith('http')) {
          uploaded.add(p);
          continue;
        }

        final file = File(p.replaceFirst(RegExp(r'^file://'), ''));
        if (!file.existsSync()) continue;

        final filename = p.split(RegExp(r"[/\\]")).last;
        final dest = 'properties/$propertyId/$filename';

        final bytes = await file.readAsBytes();

        await supabase.storage.from(bucket).uploadBinary(dest, bytes);

        final public = supabase.storage.from(bucket).getPublicUrl(dest);
        final url = public.toString();
        if (url.isNotEmpty) uploaded.add(url);
      }

      return uploaded;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
