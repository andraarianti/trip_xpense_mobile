import 'package:trip_xpense/data/models/expense_model.dart';
import 'package:trip_xpense/data/repositories/expense_repository.dart';

import '../entities/expense_entity.dart';

class ExpenseUseCase {
  var repository = ExpenseRepository();

  Future<List<ExpenseModel>> getExpenseByTripId(int tripid) async{
    try{
      final List<ExpenseModel> expenseList = await repository.getExpenseByTripId(tripid);
      return expenseList;
    }
    catch(e){
      throw('Error Trip Use Case : $e');
    }
  }

  ExpenseEntity mapToEntity(ExpenseModel expenseModel) {
    return ExpenseEntity(
      expenseId: expenseModel.expenseId,
      tripId: expenseModel.tripId,
      expenseType: expenseModel.expenseType,
      itemCost: expenseModel.itemCost,
      description: expenseModel.description,
      receiptImage: expenseModel.receiptImage,
      lastModified: expenseModel.lastModified,
      isDeleted: expenseModel.isDeleted,
      isApproved: expenseModel.isApproved,
    );
  }
}