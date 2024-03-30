import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/staff_model.dart';

class StaffRemoteDataSource {
  final String Url = "https://app.actualsolusi.com/bsi/TripXpense/api";

  Future<List<StaffModel>> getStaff() async {
    var response = await http.get(
      Uri.parse(Url + '/Staff'),
        headers: {
          "Access-Control-Allow-Origin": "*", // Required for CORS support to work
          "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        }
    );
    //print response.statuscode
    if (response.statusCode == 200){
      final jsonData = json.decode(response.body);
      List<StaffModel> staffList = [];
      for (var item in jsonData){
        staffList.add(StaffModel.fromJson(item));
      }
      return staffList;
    }
    else{
      throw Exception('Failed to Load Data Staff');
    }
  }
}