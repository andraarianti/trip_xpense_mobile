import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trip_xpense/data/models/expense_model.dart';
import '../models/staff_model.dart';

class ExpenseRemoteDataSource {
  final String Url = "https://app.actualsolusi.com/bsi/TripXpense/api";

  Future<List<ExpenseModel>> getExpenseByTripId(tripid) async {
    var response = await http.get(
        Uri.parse(Url + '/Expense/TripId?tripid=${tripid}'),
        headers: {
          "Access-Control-Allow-Origin": "*", // Required for CORS support to work
          "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        }
    );
    //print response.statuscode
    if (response.statusCode == 200){
      final jsonData = json.decode(response.body);
      List<ExpenseModel> expenseList = [];
      for (var item in jsonData){
        expenseList.add(ExpenseModel.fromJson(item));
      }
      return expenseList;
    }
    else{
      throw Exception('Failed to Load Data Staff');
    }
  }
}