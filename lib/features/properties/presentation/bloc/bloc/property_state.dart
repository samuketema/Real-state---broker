part of 'property_bloc.dart';

@immutable
sealed class PropertyState {}

final class PropertyInitial extends PropertyState {}

/// State when a loading operation is in progress.
final class PropertyLoading extends PropertyState {}

/// State when a list of properties has been loaded.
final class PropertiesLoadSuccess extends PropertyState {
  final List<Property> properties;
  PropertiesLoadSuccess(this.properties);
}

/// State when a single property has been loaded.
final class PropertyLoadSuccess extends PropertyState {
  final Property property;
  PropertyLoadSuccess(this.property);
}

/// State representing a successful CRUD operation (add/update/delete).
final class PropertyOperationSuccess extends PropertyState {}

/// State for search results.
final class PropertySearchSuccess extends PropertyState {
  final List<Property> results;
  PropertySearchSuccess(this.results);
}

/// State when an error has occurred.
final class PropertyFailure extends PropertyState {
  final String message;
  PropertyFailure(this.message);
}
