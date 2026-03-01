part of 'property_bloc.dart';

@immutable
sealed class PropertyEvent {}

/// Event to load all properties from the repository.
final class LoadAllProperties extends PropertyEvent {}

/// Event to load a single property by its [id].
final class LoadPropertyById extends PropertyEvent {
  final String id;
  LoadPropertyById(this.id);
}

/// Event to add a new property.
final class AddPropertyEvent extends PropertyEvent {
  final Property property;
  AddPropertyEvent(this.property);
}

/// Event to update an existing property.
final class UpdatePropertyEvent extends PropertyEvent {
  final Property property;
  UpdatePropertyEvent(this.property);
}

/// Event to delete a property by [id].
final class DeletePropertyEvent extends PropertyEvent {
  final String id;
  DeletePropertyEvent(this.id);
}

/// Event to search properties using optional filters.
final class SearchPropertiesEvent extends PropertyEvent {
  final String? query;
  final String? location;
  final double? minPrice;
  final double? maxPrice;
  final int? bedrooms;
  final int? bathrooms;
  final PropertyType? type;
  final ListingType? listingType;

  SearchPropertiesEvent({
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
