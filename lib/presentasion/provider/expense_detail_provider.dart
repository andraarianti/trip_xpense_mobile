import 'package:flutter/cupertino.dart';
import 'package:trip_xpense/domain/usecase/expense_usecase.dart';

import '../../data/models/expense_model.dart';

class ExpenseDetailProvider extends ChangeNotifier {
  var _expenseUseCase = ExpenseUseCase();

  ExpenseModel? _data;
  ExpenseModel? get data => _data;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasError = false;
  bool get hasError => _hasError;

  String _error = '';
  String get error => _error;

  Future<void> loadData(int expenseId) async {
    _isLoading = true;
    notifyListeners();

    try {
      var result = await _expenseUseCase.getExpenseById(expenseId);
      _data = result;
    } catch (e) {
      _hasError = true;
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshData(int tripId) async {
    if (_data != null) {
      _data = null;
      notifyListeners();
    }
    await loadData(tripId);
  }
}
