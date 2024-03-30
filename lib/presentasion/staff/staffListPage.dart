import 'package:flutter/material.dart';
import 'package:trip_xpense/domain/entities/staff_entity.dart';

import '../../domain/usecase/staff_usecase.dart';

class StaffListPage extends StatelessWidget {
  final StaffUseCase _staffUseCase = StaffUseCase();

  @override
  Widget build(BuildContext context) {
    Future<List<StaffEntity>> _staffListFuture = _staffUseCase.execute().then((staffList) {
      return staffList.map((staffModel) {
        return _staffUseCase.mapToEntity(staffModel);
      }).toList();
    }).catchError((error) {
      // Handle error here
      print('Error fetching staff list: $error');
      return <StaffEntity>[];
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Staff List'),
      ),
      body: FutureBuilder<List<StaffEntity>>(
        future: _staffListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final staffList = snapshot.data!;
            return ListView.builder(
              itemCount: staffList.length,
              itemBuilder: (context, index) {
                final staff = staffList[index];
                return Card(
                  child: ListTile(
                    title: Text(staff.name),
                    subtitle: Text(staff.role),
                    onTap: () {
                      // Handle onTap action
                    },
                    // You can add more information here if needed
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
