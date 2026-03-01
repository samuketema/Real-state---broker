import 'package:fpdart/fpdart.dart';
import 'package:realstate/core/error/failure.dart';
import 'package:realstate/core/usecase/usecase.dart';
import 'package:realstate/features/properties/domain/entities/listing_type.dart';
import 'package:realstate/features/properties/domain/entities/property.dart';
import 'package:realstate/features/properties/domain/entities/property_type.dart';
import 'package:realstate/features/properties/domain/repositories/property_repository.dart';

class SearchProperties implements Usecase<List<Property>, SearchPropertiesParams> {
  final PropertyRepository repository;
  SearchProperties({required this.repository});

  @override
  Future<Either<Failure, List<Property>>> call(SearchPropertiesParams params) async {
    return await repository.searchProperties(
      query: params.query,
      location: params.location,
      minPrice: params.minPrice,
      maxPrice: params.maxPrice,
      bedrooms: params.bedrooms,
      bathrooms: params.bathrooms,
      type: params.type,
      listingType: params.listingType,
    );
  }
}

class SearchPropertiesParams {
  final String? query;
  final String? location;
  final double? minPrice;
  final double? maxPrice;
  final int? bedrooms;
  final int? bathrooms;
  final PropertyType? type;
  final ListingType? listingType;

  SearchPropertiesParams({
    this.query,
    this.location,
    this.minPrice,
    this.maxPrice,
    this.bedrooms,
    this.bathrooms,
    this.type,
    this.listingType,
  });
}
