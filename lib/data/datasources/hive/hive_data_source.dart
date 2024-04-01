import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../models/auth/login_model.dart';

class HiveDataSource{
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(LoginResponseAdapter());
    await Hive.openBox<LoginResponse>('loginBox');
  }
}