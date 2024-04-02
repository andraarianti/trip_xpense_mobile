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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: _buildCard('Need Approval', _tripListFuture, Colors.blue), // Ubah warna untuk judul pertama
            ),
            Expanded(
              child: _buildCard('Approval Finish', _approvedTripListFuture, Colors.green), // Ubah warna untuk judul kedua
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, Future<List<TripEntity>> future, Color color) { // Tambahkan parameter color
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
            height: 100,
            width: 190,
            child: Card(
              elevation: 4,
              color: color, // Gunakan warna yang diberikan sebagai background card
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Ubah warna teks menjadi putih agar terlihat jelas di atas background card yang berwarna
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '$itemCount',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Ubah warna teks menjadi putih agar terlihat jelas di atas background card yang berwarna
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

  Future<List<TripEntity>> get _tripListFuture async {
    final tripList = await _tripUseCase.getTripInProgress();
    return tripList.map((tripModel) {
      return _tripUseCase.mapToEntity(tripModel);
    }).toList();
  }

  Future<List<TripEntity>> get _approvedTripListFuture async {
    final tripList = await _tripUseCase.getTripInProgress();
    return tripList.map((tripModel) {
      return _tripUseCase.mapToEntity(tripModel);
    }).toList();
  }
}
