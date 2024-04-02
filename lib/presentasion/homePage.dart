import 'package:flutter/material.dart';

import '../domain/entities/trip_entity.dart';
import '../domain/usecase/trip_usecase.dart';

class HomePage extends StatelessWidget {
  final TripUseCase _tripUseCase = TripUseCase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, // Atur jarak antara card menggunakan MainAxisAlignment
          children: [
            _buildCard('Need Approvals', _tripListFuture),
            _buildCard('Approval Complete', _approvedTripListFuture),
          ],
        ),
      ),
    );
  }

  // Method untuk membangun Card
  Widget _buildCard(String title, Future<List<TripEntity>> future) {
    return FutureBuilder<List<TripEntity>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final tripList = snapshot.data!;
          int itemCount = tripList.length;
          return Container(
            height: 110,
            width: 180,
            child: Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '$itemCount',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  // Future untuk mendapatkan daftar trip yang masih membutuhkan persetujuan
  Future<List<TripEntity>> get _tripListFuture async {
    final tripList = await _tripUseCase.getTripInProgress();
    return tripList.map((tripModel) {
      return _tripUseCase.mapToEntity(tripModel);
    }).toList();
  }

  // Future untuk mendapatkan daftar trip yang sudah disetujui
  Future<List<TripEntity>> get _approvedTripListFuture async {
    final tripList = await _tripUseCase.getTripInProgress();
    return tripList.map((tripModel) {
      return _tripUseCase.mapToEntity(tripModel);
    }).toList();
  }
}
