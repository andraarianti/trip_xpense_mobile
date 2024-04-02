import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:trip_xpense/data/models/trip_model.dart';

import '../models/auth/login_model.dart';

class TripRemoteDataSource {

  final String Url = "https://app.actualsolusi.com/bsi/TripXpense/api";
  final String _token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6Imt1cm5pYXNhcmkiLCJuYmYiOjE3MTE5NTMwNDEsImV4cCI6MTcxMjAzOTQ0MSwiaWF0IjoxNzExOTUzMDQxfQ.4Nhy-Enc_HycHmjxOPR4xoyMOTcvfI5_XYKRya-eZ5Q";
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

  Future<TripModel> getTripById(int id) async {
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
      return TripModel.fromJson(jsonData);
    }
    else{
      throw Exception('Failed to Load Data Trip Detail');
    }
  }
}