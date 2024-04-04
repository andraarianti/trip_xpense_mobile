
// Define abstract repository for toggle button state
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class ToggleButtonRepository {
  bool get isSelected1;
  bool get isSelected2;
  void toggleButton1();
  void toggleButton2();
}

class ToggleButtonProvider extends ChangeNotifier {
  bool _isSelected1 = true;
  bool _isSelected2 = false;

  bool get isSelected1 => _isSelected1;
  bool get isSelected2 => _isSelected2;

  void toggleButton1() {
    _isSelected1 = !_isSelected1;
    _isSelected2 = false;
    notifyListeners();
  }

  void toggleButton2() {
    _isSelected2 = !_isSelected2;
    _isSelected1 =false;
    notifyListeners();
  }

  void resetButtons() {
    _isSelected1 = false;
    _isSelected2 = false;
    notifyListeners();
  }
}
