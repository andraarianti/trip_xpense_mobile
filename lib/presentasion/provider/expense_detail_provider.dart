import 'package:flutter/cupertino.dart';
import 'package:trip_xpense/domain/usecase/expense_usecase.dart';

import '../../data/models/expense_model.dart';

class ExpenseDetailProvider extends ChangeNotifier {
  late final ExpenseUseCase _expenseUseCase;

  ExpenseModel? _data;
  ExpenseModel? get data => _data;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasError = false;
  bool get hasError => _hasError;

  String _error = '';
  String get error => _error;

  ExpenseDetailProvider() {
    _expenseUseCase = ExpenseUseCase();
  }

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

  Future<void> refreshData(int expenseId) async {
    _isLoading = true;
    _hasError = false;
    _error = '';
    notifyListeners();

    await loadData(expenseId);

    _isLoading = false;
    notifyListeners();
  }
}
