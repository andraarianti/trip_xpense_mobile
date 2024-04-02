import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        title: Text('Trip List'),
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
