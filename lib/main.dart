import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:trip_xpense/presentasion/provider/bottom_navigation.dart';
import 'package:trip_xpense/presentasion/provider/expense_detail_provider.dart';
import 'package:trip_xpense/presentasion/provider/expense_list_provider.dart';
import 'package:trip_xpense/presentasion/provider/profile_provider.dart';
import 'package:trip_xpense/presentasion/provider/toggle_button_provider.dart';
import 'package:trip_xpense/presentasion/provider/trip_detail_provider.dart';
import 'package:trip_xpense/presentasion/provider/trip_provider.dart';
import 'package:trip_xpense/presentasion/provider/trip_waiting_approval_provider.dart';
import 'package:trip_xpense/presentasion/splashScreen.dart';

import 'data/datasources/hive/hive_data_source.dart';
import 'data/models/auth/login_model.dart';
import 'domain/usecase/login_usecase.dart';

final getIt = GetIt.instance;

//semua pengaturan akan ada disini
void setup() {}

void main() async {
  //runApp(const MyApp());
  setup();
  HiveDataSource hiveDataSource = HiveDataSource();
  await hiveDataSource.init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<BottomNavigationProvider>(
        create: (_) => BottomNavigationProvider(),
      ),
      ChangeNotifierProvider<LoginUseCase>(create: (_) => LoginUseCase()),
      ChangeNotifierProvider<TripProvider>(create: (_) => TripProvider()),
      ChangeNotifierProvider<ExpenseListProvider>(
          create: (_) => ExpenseListProvider()),
      ChangeNotifierProvider<ExpenseDetailProvider>(
          create: (_) => ExpenseDetailProvider()),
      ChangeNotifierProvider<ProfileProvider>(create: (_) => ProfileProvider()),
      ChangeNotifierProvider<TripDetailProvider>(
          create: (_) => TripDetailProvider()),
      ChangeNotifierProvider<TripInProgressProvider>(
          create: (_) => TripInProgressProvider()),
      ChangeNotifierProvider<ToggleButtonProvider>(
          create: (_) => ToggleButtonProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Cek apakah pengguna sudah login atau belum
    final Box<LoginResponse> box = Hive.box('loginBox');
    bool isLoggedIn = box.isNotEmpty;

    return MaterialApp(
      home: isLoggedIn
          ? BottomNavigation()
          : SplashScreen(), // Jika belum login, arahkan ke halaman login
    );
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    var botNav = Provider.of<BottomNavigationProvider>(context);
    return MaterialApp(
      home: Scaffold(
        body: Center(child: botNav.widgetOptions()),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            barItem(Icons.home, 'Home'),
            barItem(Icons.airplane_ticket, 'Trips'),
            barItem(Icons.person_2, 'Profile'),
          ],
          currentIndex:
              Provider.of<BottomNavigationProvider>(context).selectedIndex,
          selectedItemColor: Colors.lightBlueAccent,
          onTap: Provider.of<BottomNavigationProvider>(context, listen: false)
              .setSelectedIndex,
        ),
      ),
    );
  }

  BottomNavigationBarItem barItem(IconData iconData, String label) {
    return BottomNavigationBarItem(
      icon: Icon(iconData),
      label: label,
    );
  }
}
