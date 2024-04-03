import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:trip_xpense/data/models/auth/login_model.dart';
import 'package:trip_xpense/domain/entities/staff_entity.dart';
import 'package:trip_xpense/domain/usecase/staff_usecase.dart';
import 'package:trip_xpense/presentasion/auth/login.dart';
import 'package:trip_xpense/presentasion/provider/profile_provider.dart';

import '../../data/models/staff_model.dart';
import '../../data/datasources/hive/hive_data_source.dart';

class StaffProfilePage extends StatelessWidget {
  final StaffUseCase _staffUseCase = StaffUseCase();

  void _logout(BuildContext context) {
    final Box<LoginResponse> box = Hive.box('loginBox');
    box.clear(); // Clear login data
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Box<LoginResponse> box = Hive.box('loginBox');
    if (box.isEmpty) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      });
    }
    final LoginResponse? staff = box.getAt(0);
    String? username = staff?.username;

    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFD0B3FF),
                Color(0xFFAFCBFF), // Lighter version of Colors.lightBlue
                Color(0xFFD7F9FF), // Lighter version of Colors.lightBlue
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),// Logout function
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<List<StaffEntity>>(
          future: _staffUseCase.getByUsername(username!).then((List<StaffModel> staffModels) {
            // Convert List<StaffModel> to List<StaffEntity>
            return staffModels.map((staffModel) {
              return StaffEntity(
                staffID: staffModel.staffID,
                name: staffModel.name,
                positionID: staffModel.positionID,
                role: staffModel.role,
                lastModified: staffModel.lastModified,
                isDeleted: staffModel.isDeleted,
                username: staffModel.username,
                password: staffModel.password,
                email: staffModel.email,
                lastLogin: staffModel.lastLogin,
                maxAttempt: staffModel.maxAttempt,
                isLocked: staffModel.isLocked,
              );
            }).toList();
          }),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show a loading indicator while waiting for the future to complete
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Show an error message if the future throws an error
              return Text('Error: ${snapshot.error}');
            } else {
              // Once the future completes, display the staff details
              final staffList = snapshot.data;
              if (staffList != null && staffList.isNotEmpty) {
                // karena Anda hanya ingin menampilkan satu item, Anda dapat mengambil item pertama dari daftar
                final staffData = staffList[0];
                return ListTile(
                  title: Text('Name: ${staffData.name}'),
                  subtitle: Text('StaffId: ${staff?.staffId}'),
                  // Add more staff details here as needed
                );
              } else {
                return Text('No staff found');
              }
            }
          },
        ),
      ),
    );
  }
}
