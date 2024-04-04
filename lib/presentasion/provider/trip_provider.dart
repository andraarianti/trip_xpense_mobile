import 'package:flutter/cupertino.dart';
import 'package:trip_xpense/data/models/staff_model.dart';
import 'package:trip_xpense/domain/usecase/trip_usecase.dart';

import '../../data/models/trip_model.dart';

class TripProvider extends ChangeNotifier {
  var _tripUseCase = TripUseCase();

  List<TripModel> _data = [];

  List<TripModel> get data => _data;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _hasError = false;

  bool get hasError => _hasError;

  String _error = '';

  String get error => _error;

  Future<void> getTripList(String status) async {
    try {
      var result = await _tripUseCase.getTripWithoutDrafted();
      _data = await result
          .where((entity) => entity.statusName == status)
          .toList();
    } catch (e) {
      // Tangani kesalahan jika terjadi
      _hasError = true;
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadData(String status) async {
    _data.clear();
    await getTripList(status);
    notifyListeners();
  }

  Future<void> getTrip() async {
    _isLoading = true;
    notifyListeners();

    try {
      var result = await _tripUseCase.getTripWithoutDrafted();
      _data.addAll(result);
      // Urutkan data berdasarkan status, dengan "In Progress" di bagian atas
      _data.sort((a, b) {
        if (a.statusName == 'In Progress') {
          return -1; // a ditempatkan sebelum b
        } else if (b.statusName == 'In Progress') {
          return 1; // b ditempatkan sebelum a
        } else {
          return 0; // kedua trip memiliki status yang sama
        }
      }
      );
    } catch (e) {
      _hasError = true;
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshData() async {
    _data.clear();
    notifyListeners();
    await getTrip();
  }


}
