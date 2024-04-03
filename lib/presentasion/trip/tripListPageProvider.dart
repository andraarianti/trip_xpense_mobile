import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_xpense/presentasion/trip/tripDetailPage.dart';
import 'package:trip_xpense/presentasion/trip/tripDetailPageProvider.dart';

import '../provider/trip_provider.dart';

class TripPageProvider extends StatelessWidget {
  const TripPageProvider({Key? key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TripProvider>(context, listen: false).refreshData();
    });
    return Scaffold(
      appBar: AppBar(
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
        title: Text(
          'Trip List',
          style: TextStyle(
            fontSize: 24, // Adjust the font size as needed
            fontWeight: FontWeight.bold, // Make the text bold
            color: Colors.white, // Set the text color to white
          ),
        ),
      ),
      body: Consumer<TripProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.hasError) {
            print('Error : ${provider.error}');
            return Center(child: Text('Error: ${provider.error}'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: provider.data.length,
                itemBuilder: (context, index) {
                  final trip = provider.data[index];
                  print('Data Trip : ${provider.data[1]}');
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TripDetailPageProvider(trips: trip), // Melewatkan nilai tripId
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
