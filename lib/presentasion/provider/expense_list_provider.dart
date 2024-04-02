import 'package:flutter/cupertino.dart';
import 'package:trip_xpense/domain/usecase/expense_usecase.dart';

import '../../data/models/expense_model.dart';

class ExpenseListProvider extends ChangeNotifier{
  var _expenseUseCase = ExpenseUseCase();

  List<ExpenseModel> _data = [];
  List<ExpenseModel> get data => _data;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasError = false;
  bool get hasError => _hasError;

  String _error = '';
  String get error => _error;

  Future<void> loadData(int tripId) async{
    try{
      var result = await _expenseUseCase.getExpenseByTripId(tripId);
      _data.addAll(result);
    }
    catch (e) {
      _hasError = true;
      _error = e.toString();
    }
    finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<void> refreshData(int tripId) async {
    _data.clear();
    await loadData(tripId);
  }

}