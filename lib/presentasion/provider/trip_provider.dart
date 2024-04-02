import 'package:flutter/cupertino.dart';
import 'package:trip_xpense/data/models/staff_model.dart';
import 'package:trip_xpense/domain/usecase/trip_usecase.dart';

import '../../data/models/trip_model.dart';

class TripProvider extends ChangeNotifier{
  var _tripUseCase = TripUseCase();

  List<TripModel> _data = [];
  List<TripModel> get data => _data;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasError = false;
  bool get hasError => _hasError;

  String _error = '';
  String get error => _error;

  Future<void> getTripInProgress() async {
    try{
      var result = await _tripUseCase.getTripInProgress();
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

  Future<void> refreshData() async {
    _data.clear();
    await getTripInProgress();
  }
}