import 'package:realstate/features/properties/domain/entities/listing_type.dart';
import 'package:realstate/features/properties/domain/entities/property_type.dart';
import '../../domain/entities/property.dart';

/// A data-transfer object representing a property in the remote data source.
///
/// Extends the domain entity so it can be used interchangeably where only
/// read-only access is required.  Conversion helpers allow easy JSON mapping.
final class PropertyModel extends Property {
  const PropertyModel({
    required String id,
    required String title,
    required String description,
    required double price,
    required String location,
    required List<String> imageUrls,
    required int bedrooms,
    required int bathrooms,
    required ListingType listingType,
    required double area,
    required PropertyType type,
    required DateTime createdAt,
  }) : super(
          id: id,
          title: title,
          description: description,
          price: price,
          location: location,
          imageUrls: imageUrls,
          bedrooms: bedrooms,
          bathrooms: bathrooms,
          listingType: listingType,
          area: area,
          type: type,
          createdAt: createdAt,
        );

  /// Creates a [PropertyModel] from a JSON map received from Supabase or any
  /// other backend.  This expects the enum values to be stored as their
  /// `.name` string representations.
  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      location: json['location'] as String,
      imageUrls: List<String>.from(json['image_urls'] as List<dynamic>),
      bedrooms: json['bedrooms'] as int,
      bathrooms: json['bathrooms'] as int,
      listingType: ListingType.values.firstWhere(
        (e) => e.name == (json['listing_type'] as String),
        orElse: () => ListingType.sale,
      ),
      area: (json['area'] as num).toDouble(),
      type: PropertyType.values.firstWhere(
        (e) => e.name == (json['type'] as String),
        orElse: () => PropertyType.apartment,
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  /// Converts this model to a JSON map suitable for sending to a remote API
  /// or Supabase insert/update calls.  DateTimes are converted to ISO strings
  /// and enums to their `.name` values.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'location': location,
      'image_urls': imageUrls,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'listing_type': listingType.name,
      'area': area,
      'type': type.name,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
