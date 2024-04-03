import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:trip_xpense/data/models/trip_detail_model.dart';
import 'package:trip_xpense/data/models/trip_model.dart';

import '../models/auth/login_model.dart';

class TripRemoteDataSource {

  static final Box<LoginResponse> box = Hive.box('loginBox');
  static final LoginResponse? staff = box.getAt(0);
  final String? _token = staff?.token;

  final String Url = "https://app.actualsolusi.com/bsi/TripXpense/api";
  //final String _token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6Imt1cm5pYXNhcmkiLCJuYmYiOjE3MTIwMzg2NzUsImV4cCI6MTcxMjEyNTA3NSwiaWF0IjoxNzEyMDM4Njc1fQ.HEaQ3kGm9TiRTpt7V1iDGjPbLrOoYb4aerLR0KM-EHw";
  Future<List<TripModel>> getTripInProgress() async {
    var response = await http.get(
        Uri.parse(Url + '/Trip/TripInProgress'),
        headers: {
          "Access-Control-Allow-Origin": "*", // Required for CORS support to work
          "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS",
          'Authorization': 'Bearer $_token',
        }
    );
    //print response.statuscode
    if (response.statusCode == 200){
      final jsonData = json.decode(response.body);
      List<TripModel> tripList = [];
      for (var item in jsonData){
        tripList.add(TripModel.fromJson(item));
      }
      return tripList;
    }
    else{
      throw Exception('Failed to Load Data Trip');
    }
  }

  Future<List<TripModel>> getTripWithoutDrafted() async {
    var response = await http.get(
        Uri.parse(Url + '/Trip/TripWithoutDrafted'),
        headers: {
          "Access-Control-Allow-Origin": "*", // Required for CORS support to work
          "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS",
          'Authorization': 'Bearer $_token',
        }
    );
    //print response.statuscode
    if (response.statusCode == 200){
      final jsonData = json.decode(response.body);
      List<TripModel> tripList = [];
      for (var item in jsonData){
        tripList.add(TripModel.fromJson(item));
      }
      return tripList;
    }
    else{
      throw Exception('Failed to Load Data Trip');
    }
  }

  Future<TripDetailModel> getTripById(int id) async {
    var response = await http.get(
        Uri.parse(Url + '/Trip/$id'),
        headers: {
          "Access-Control-Allow-Origin": "*", // Required for CORS support to work
          "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS",
          'Authorization': 'Bearer $_token',
        }
    );
    //print response.statuscode
    if (response.statusCode == 200){
      final jsonData = json.decode(response.body);
      return TripDetailModel.fromJson(jsonData);
    }
    else{
      throw Exception('Failed to Load Data Trip Detail');
    }
  }

  Future<TripModel> submitTripApproval(int tripid) async {
    var response = await http.put(
        Uri.parse(Url + '/Trip/SubmitTripApproval/${tripid}'),
        headers: {
          "Access-Control-Allow-Origin": "*", // Required for CORS support to work
          "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS",
          'Authorization': 'Bearer $_token',
        }
    );
    //print response.statuscode
    if (response.statusCode == 200){
      final jsonData = json.decode(response.body);
      return TripModel.fromJson(jsonData);
    }
    else{
      throw Exception('Failed to Load Data Trip Detail');
    }
  }
}