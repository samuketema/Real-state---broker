import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:realstate/core/usecase/usecase.dart';

import 'package:realstate/features/properties/domain/entities/property.dart';
import 'package:realstate/features/properties/domain/entities/listing_type.dart';
import 'package:realstate/features/properties/domain/entities/property_type.dart';
import 'package:realstate/features/properties/domain/usecases/add_property.dart';
import 'package:realstate/features/properties/domain/usecases/delete_property.dart';
import 'package:realstate/features/properties/domain/usecases/get_all_properties.dart';
import 'package:realstate/features/properties/domain/usecases/get_property_by_id.dart';
import 'package:realstate/features/properties/domain/usecases/search_properties.dart';
import 'package:realstate/features/properties/domain/usecases/update_property.dart';

part 'property_event.dart';
part 'property_state.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  final GetAllProperties _getAll;
  final GetPropertyById _getById;
  final AddProperty _add;
  final UpdateProperty _update;
  final DeleteProperty _delete;
  final SearchProperties _search;

  PropertyBloc({
    required GetAllProperties getAll,
    required GetPropertyById getById,
    required AddProperty add,
    required UpdateProperty update,
    required DeleteProperty delete,
    required SearchProperties search,
  })  : _getAll = getAll,
        _getById = getById,
        _add = add,
        _update = update,
        _delete = delete,
        _search = search,
        super(PropertyInitial()) {
    on<LoadAllProperties>(_onLoadAll);
    on<LoadPropertyById>(_onLoadById);
    on<AddPropertyEvent>(_onAdd);
    on<UpdatePropertyEvent>(_onUpdate);
    on<DeletePropertyEvent>(_onDelete);
    on<SearchPropertiesEvent>(_onSearch);
  }

  Future<void> _onLoadAll(
      LoadAllProperties event, Emitter<PropertyState> emit) async {
    emit(PropertyLoading());
    final res = await _getAll.call(NoParams());
    res.fold(
      (f) => emit(PropertyFailure(f.message)),
      (props) => emit(PropertiesLoadSuccess(props)),
    );
  }

  Future<void> _onLoadById(
      LoadPropertyById event, Emitter<PropertyState> emit) async {
    emit(PropertyLoading());
    final res = await _getById.call(GetPropertyByIdParams(id: event.id));
    res.fold(
      (f) => emit(PropertyFailure(f.message)),
      (prop) => emit(PropertyLoadSuccess(prop)),
    );
  }

  Future<void> _onAdd(
      AddPropertyEvent event, Emitter<PropertyState> emit) async {
    emit(PropertyLoading());
    final res = await _add.call(event.property);
    res.fold(
      (f) => emit(PropertyFailure(f.message)),
      (_) async {
        emit(PropertyOperationSuccess());
        add(LoadAllProperties()); // refresh list
      },
    );
  }

  Future<void> _onUpdate(
      UpdatePropertyEvent event, Emitter<PropertyState> emit) async {
    emit(PropertyLoading());
    final res = await _update.call(event.property);
    res.fold(
      (f) => emit(PropertyFailure(f.message)),
      (_) async {
        emit(PropertyOperationSuccess());
        add(LoadAllProperties());
      },
    );
  }

  Future<void> _onDelete(
      DeletePropertyEvent event, Emitter<PropertyState> emit) async {
    emit(PropertyLoading());
    final res = await _delete.call(DeletePropertyParams(id: event.id));
    res.fold(
      (f) => emit(PropertyFailure(f.message)),
      (_) async {
        emit(PropertyOperationSuccess());
        add(LoadAllProperties());
      },
    );
  }

  Future<void> _onSearch(
      SearchPropertiesEvent event, Emitter<PropertyState> emit) async {
    emit(PropertyLoading());
    final res = await _search.call(SearchPropertiesParams(
      query: event.query,
      location: event.location,
      minPrice: event.minPrice,
      maxPrice: event.maxPrice,
      bedrooms: event.bedrooms,
      bathrooms: event.bathrooms,
      type: event.type,
      listingType: event.listingType,
    ));
    res.fold(
      (f) => emit(PropertyFailure(f.message)),
      (list) => emit(PropertySearchSuccess(list)),
    );
  }
}
