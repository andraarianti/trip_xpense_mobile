import 'package:trip_xpense/data/datasources/staff_remote_data_source.dart';
import 'package:trip_xpense/data/models/auth/login_model.dart';
import 'package:trip_xpense/data/models/staff_model.dart';

class StaffRepository{

  var remoteDataSource = StaffRemoteDataSource();

  Future<List<StaffModel>> getStaff() async{
    try{
      final List<StaffModel> staffList = await remoteDataSource.getStaff();
      return staffList;
    }
    catch (e){
      throw 'Error Repo Get Staff : ${e}';
    }
  }

  Future<LoginResponse> login(String username, String password) async {
    try {
      final LoginResponse login = await remoteDataSource.login(username, password);
      return login;
    } catch (e) {
      throw Exception('Error Repo Login: $e'); // Menangkap pengecualian dengan tipe Exception
    }
  }

  Future<List<StaffModel>> getByUsername(String username) async{
    try{
      final List<StaffModel> staff = await remoteDataSource.getByUsername(username);
      return staff;
    }
    catch (e) {
      throw Exception('Error Repo GetById: $e'); // Menangkap pengecualian dengan tipe Exception
    }
  }
}