import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:trip_xpense/data/models/staff_model.dart';
import 'package:trip_xpense/data/repositories/staff_repository.dart';
import 'package:trip_xpense/domain/entities/staff_entity.dart';

class StaffUseCase{
  var repository = StaffRepository();

  Future<List<StaffModel>> execute() async {
    try{
      final List<StaffModel> staffList = await repository.getStaff();
      return staffList;
    }
    catch (e){
      throw('Error Staff Use Case : $e');
    }
  }

  Future<List<StaffModel>> getByUsername(String username) async{
    try{
      final List<StaffModel> staff = await repository.getByUsername(username);
      return staff;
    }
    catch (e){
      throw('Error Staff Use Case : $e');
    }
  }

  StaffEntity mapToEntity(StaffModel staffModel){
    return StaffEntity(
        staffID: staffModel.staffID,
        name: staffModel.name,
        positionID: staffModel.positionID,
        role: staffModel.role,
        isDeleted: staffModel.isDeleted,
        username: staffModel.username,
        password: staffModel.password,
        email: staffModel.email,
        maxAttempt: staffModel.maxAttempt,
        isLocked: staffModel.isLocked
    );
  }
}