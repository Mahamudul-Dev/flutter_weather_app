import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';
import '../../repository/repository.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository repository;
  String _selectedCountry = '';
  String _selectedState = '';
  String _selectedCity = '';
  LocationBloc(this.repository) : super(LocationInitial()) {
    on<FetchUserLocation>((event, emit) async {
      await repository.getUserLocation().then((location) {
        if(location.errorMessage == null){
          emit(LocationLoaded(location: location));
        } else {
          LocationLoadFailed(message: location.errorMessage!);
        }
      });
    });


    on<ChangeUserLocation>((event, emit) => emit(LocationLoaded(location: LocationModel(city: _selectedCity, country: _selectedCountry, state: _selectedState))));
  }

  void changeCountry(String newCountry){
    _selectedCountry = newCountry;
  }
  void changeState(String newState){
    _selectedState = newState;
  }
  void changeCity(String newCity){
    _selectedCity = newCity;
  }
}
