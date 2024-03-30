import 'dart:async';

import 'package:trip_xpense/data/models/trip_model.dart';
import 'package:trip_xpense/data/repositories/trip_repository.dart';
import 'package:trip_xpense/domain/entities/trip_entity.dart';

class TripUseCase {
  var repository = TripRepository();

  Future<List<TripModel>> execute() async{
    try{
      final List<TripModel> tripList = await repository.getTripInProgress();
      return tripList;
    }
    catch(e){
      throw('Error Trip Use Case : $e');
    }
  }

  Future<TripModel> getTripById(int id) async {
    try {
      final trip = await repository.getTripById(id);
      return trip;
    } catch (e) {
      // Handle error
      throw e;
    }
  }

  TripEntity mapToEntity(TripModel tripModel){
    DateTime startDate = DateTime.parse(tripModel.startDate);
    DateTime endDate = DateTime.parse(tripModel.endDate);

    return TripEntity(
        tripId: tripModel.tripId,
        submittedBy: tripModel.submittedBy,
        location: tripModel.location,
        startDate: startDate,
        endDate: endDate,
        statusId: tripModel.statusId,
        statusName: tripModel.statusName,
        staffName: tripModel.staffName
    );
  }
}