import 'package:flutter/material.dart';
import 'package:trip_xpense/domain/entities/staff_entity.dart';

import '../../domain/usecase/staff_usecase.dart';

class StaffListPage extends StatefulWidget {
  @override
  _StaffListPageState createState() => _StaffListPageState();
}

class _StaffListPageState extends State<StaffListPage> {
  final StaffUseCase _staffUseCase = StaffUseCase();
  late Future<List<StaffEntity>> _staffListFuture;

  @override
  void initState() {
    super.initState();
    _staffListFuture = _staffUseCase.execute().then((staffList) {
      return staffList.map((staffModel) {
        return _staffUseCase.mapToEntity(staffModel);
      }).toList();
    }).catchError((error) {
      // Handle error here
      print('Error fetching staff list: $error');
      return <StaffEntity>[];
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    onTap: (){
                      
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