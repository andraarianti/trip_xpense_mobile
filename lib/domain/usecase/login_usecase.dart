import 'package:flutter/cupertino.dart';
import 'package:trip_xpense/data/models/auth/login_model.dart';
import 'package:trip_xpense/data/repositories/staff_repository.dart';

class LoginUseCase extends ChangeNotifier{
  var repository = StaffRepository();

  Future<LoginResponse> login(String username, String password) async{
    try{
      final LoginResponse login = await repository.login(username, password);
      return login;
    }
    catch(e){
      throw('Error Login Use Case : $e');
    }
  }
}