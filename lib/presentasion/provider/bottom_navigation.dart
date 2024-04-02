import 'package:flutter/cupertino.dart';
import 'package:trip_xpense/presentasion/homePage.dart';
import 'package:trip_xpense/presentasion/staff/staffListPage.dart';
import 'package:trip_xpense/presentasion/staff/staffProfilePage.dart';
import 'package:trip_xpense/presentasion/trip/tripListPage.dart';
import 'package:trip_xpense/presentasion/trip/tripListPageProvider.dart';

class BottomNavigationProvider extends ChangeNotifier{
  int _selectIndex;

  BottomNavigationProvider([this._selectIndex = 0]);
  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    //TripListPage(),
    TripPageProvider(),
    StaffProfilePage()
  ];

  int get selectedIndex => _selectIndex;

  void setSelectedIndex(int index){
    _selectIndex = index;
    notifyListeners();
  }

  Widget widgetOptions(){
    return _widgetOptions[_selectIndex];
  }
}