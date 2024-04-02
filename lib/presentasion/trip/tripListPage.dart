import 'package:flutter/material.dart';
import 'package:trip_xpense/domain/entities/trip_entity.dart';
import 'package:trip_xpense/domain/usecase/trip_usecase.dart';
import 'package:trip_xpense/presentasion/trip/tripDetailPage.dart';

class TripListPage extends StatelessWidget {
  final TripUseCase _tripUseCase = TripUseCase();

  @override
  Widget build(BuildContext context) {
    Future<List<TripEntity>> _tripListFuture = _tripUseCase.getTripInProgress().then((tripList){
      return tripList.map((tripModel) {
        return _tripUseCase.mapToEntity(tripModel);
      }).toList();
    }).catchError((error) {
      // Handle error here
      print('Error fetching trip list: $error');
      return <TripEntity>[];
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Need Approval Trip List'),
      ),
      body: FutureBuilder<List<TripEntity>>(
        future: _tripListFuture,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(snapshot.hasError){
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          else {
            final tripList = snapshot.data!;
            return ListView.builder(
                itemCount: tripList.length,
                itemBuilder: (context, index){
                  final trip = tripList[index];
                  return Card(
                  child: ListTile(
                    title: Text(
                      'ID: ${trip.tripId} - Status: ${trip.statusName}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Staff Name: ${trip.staffName}'),
                        Text('${trip.location} - \$ ${trip.totalCost}'),
                      ],
                    ),
                    onTap: () {
                      // Handle onTap action
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TripDetailPage(trip: trip), // Melewatkan nilai tripId
                        ),
                      );
                    },
                    // You can add more information here if needed
                  ),
                  );
                }
            );
          }
        },
      ),
    );
  }
}
