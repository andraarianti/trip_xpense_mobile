import 'package:trip_xpense/data/datasources/staff_remote_data_source.dart';
import 'package:trip_xpense/data/models/staff_model.dart';

class StaffRepository{

  var remoteDataSource = StaffRemoteDataSource();

  Future<List<StaffModel>> getStaff() async{
    try{
      final List<StaffModel> staffList = await remoteDataSource.getStaff();
      return staffList;
    }
    catch (e){
      rethrow;
    }
  }

}