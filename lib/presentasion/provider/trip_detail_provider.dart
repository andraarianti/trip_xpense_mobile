import 'package:flutter/cupertino.dart';
import 'package:trip_xpense/domain/usecase/trip_usecase.dart';
import '../../data/models/trip_detail_model.dart';

class TripDetailProvider extends ChangeNotifier {
  var _tripUseCase = TripUseCase();

  TripDetailModel? _data;
  TripDetailModel? get data => _data;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasError = false;
  bool get hasError => _hasError;

  String _error = '';
  String get error => _error;

  Future<void> loadData(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      var result = await _tripUseCase.getTripById(id);
      _data = result;
    } catch (e) {
      _hasError = true;
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshData(int id) async {
    if (_data != null) {
      _data = null;
      notifyListeners();
    }
    await loadData(id);
  }
}
