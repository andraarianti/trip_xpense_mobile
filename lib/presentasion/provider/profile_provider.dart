import 'package:flutter/cupertino.dart';
import 'package:trip_xpense/data/models/staff_model.dart';
import 'package:trip_xpense/domain/usecase/staff_usecase.dart';
import 'package:trip_xpense/domain/usecase/trip_usecase.dart';

import '../../data/models/trip_model.dart';

class ProfileProvider extends ChangeNotifier{
  var _staffUseCase = StaffUseCase();

  List<StaffModel> _data = [];
  List<StaffModel> get data => _data;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasError = false;
  bool get hasError => _hasError;

  String _error = '';
  String get error => _error;

  Future<void> getStaffByUsername(String username) async {
    _isLoading = true;
    notifyListeners();

    try{
      var result = await _staffUseCase.getByUsername(username);
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

  Future<void> refreshData(String username) async {
    _data.clear();
    notifyListeners();
    await getStaffByUsername(username);
  }
}