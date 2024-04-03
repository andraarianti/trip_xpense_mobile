import 'package:trip_xpense/data/datasources/staff_remote_data_source.dart';
import 'package:trip_xpense/data/datasources/trip_remote_data_source.dart';
import 'package:trip_xpense/data/models/staff_model.dart';
import 'package:trip_xpense/data/models/trip_detail_model.dart';
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

  Future<List<TripModel>> getTripWithoutDrafted() async{
    try{
      final List<TripModel> tripList = await remoteDataSource.getTripWithoutDrafted();
      return tripList;
    }
    catch (e){
      rethrow;
    }
  }

  Future<TripDetailModel> getTripById(int id) async{
    try{
      final trip = await remoteDataSource.getTripById(id);
      return trip;
    }
    catch (e){
      rethrow;
    }
  }

  Future<TripModel> submitTripApproval(int tripid) async{
    try{
      final trip = await remoteDataSource.submitTripApproval(tripid);
      return trip;
    }
    catch (e){
      rethrow;
    }
  }
}