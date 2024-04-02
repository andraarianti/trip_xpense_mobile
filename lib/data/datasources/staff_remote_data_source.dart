import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../models/auth/login_model.dart';
import '../models/staff_model.dart';

class StaffRemoteDataSource {
  final String Url = "https://app.actualsolusi.com/bsi/TripXpense/api";

  Future<List<StaffModel>> getStaff() async {
    var response = await http.get(Uri.parse(Url + '/Staff'), headers: {
      "Access-Control-Allow-Origin": "*",
      // Required for CORS support to work
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    });
    //print response.statuscode
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<StaffModel> staffList = [];
      for (var item in jsonData) {
        staffList.add(StaffModel.fromJson(item));
      }
      return staffList;
    } else {
      throw Exception('Failed to Load Data Staff');
    }
  }


  Future<List<StaffModel>> getByUsername(String username) async {
    final response = await http.get(
      Uri.parse('$Url/Staff/Username/$username'),
      headers: {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Headers":
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      },
    );

    if (response.statusCode == 200) {
      // Ubah penguraian respons JSON menjadi List<StaffModel>
      List<dynamic> data = jsonDecode(response.body);
      List<StaffModel> staffList = data.map((item) => StaffModel.fromJson(item)).toList();
      return staffList;
    } else {
      throw Exception('Failed to getByUsername: ${response.statusCode}');
    }
  }

  static Future<void> saveLoginResponse(LoginResponse loginResponse) async {
    final box = await Hive.openBox<LoginResponse>('loginBox');
    await box.put('login', loginResponse);
  }

  Future<LoginResponse> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(Url + '/Staff/Login'),
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'Username': username,
        'Password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final loginResponse = LoginResponse.fromJson(responseData);

      // Simpan data LoginResponse ke Hive
      await saveLoginResponse(loginResponse);

      return loginResponse;
    } else {
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }
}
