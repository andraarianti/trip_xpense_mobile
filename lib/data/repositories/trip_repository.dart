import 'package:trip_xpense/data/datasources/staff_remote_data_source.dart';
import 'package:trip_xpense/data/datasources/trip_remote_data_source.dart';
import 'package:trip_xpense/data/models/staff_model.dart';
import 'package:trip_xpense/data/models/trip_model.dart';

class TripRepository{

  var remoteDataSource = TripRemoteDataSource();

  Future<List<TripModel>> getTripInProgress() async{
    try{
      final List<TripModel> tripList = await remoteDataSource.getTripInProgress();
      return tripList;
    }
    catch (e){
      rethrow;
    }
  }

  Future<TripModel> getTripById(int id) async{
    try{
      final trip = await remoteDataSource.getTripById(id);
      return trip;
    }
    catch (e){
      rethrow;
    }
  }
}