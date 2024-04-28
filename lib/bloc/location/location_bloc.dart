import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';
import '../../repository/repository.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository repository;
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
  }
}
