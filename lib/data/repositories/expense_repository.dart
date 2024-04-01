import 'package:trip_xpense/data/datasources/expense_remote_data_source.dart';
import 'package:trip_xpense/data/datasources/staff_remote_data_source.dart';
import 'package:trip_xpense/data/datasources/trip_remote_data_source.dart';
import 'package:trip_xpense/data/models/expense_model.dart';
import 'package:trip_xpense/data/models/staff_model.dart';
import 'package:trip_xpense/data/models/trip_model.dart';

class ExpenseRepository{

  var remoteDataSource = ExpenseRemoteDataSource();

  Future<List<ExpenseModel>> getExpenseByTripId(int tripid) async{
    try{
      final expense = await remoteDataSource.getExpenseByTripId(tripid);
      return expense;
    }
    catch (e){
      rethrow;
    }
  }
}