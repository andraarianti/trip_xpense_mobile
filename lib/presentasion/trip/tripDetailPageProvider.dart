import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trip_xpense/data/models/trip_model.dart';
import 'package:trip_xpense/domain/entities/expense_entity.dart';
import 'package:trip_xpense/domain/usecase/expense_usecase.dart';
import 'package:trip_xpense/domain/usecase/trip_usecase.dart';
import 'package:trip_xpense/presentasion/provider/expense_list_provider.dart';
import 'package:trip_xpense/presentasion/provider/trip_detail_provider.dart';
import 'package:trip_xpense/presentasion/provider/trip_provider.dart';
import 'package:trip_xpense/presentasion/trip/expenseDetailPage.dart';

import '../../data/models/trip_detail_model.dart';
import '../../domain/entities/trip_entity.dart';

class TripDetailPageProvider extends StatelessWidget {
  final TripModel trips;
  final TripUseCase _tripUseCase = TripUseCase();

  TripDetailPageProvider({Key? key, required this.trips}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExpenseListProvider>(context, listen: false)
          .refreshData(trips.tripId);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TripDetailProvider>(context, listen: false)
          .refreshData(trips.tripId);
    });

    final dateFormat = DateFormat('dd MMMM yyyy');

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.airplane_ticket_rounded,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Trip Xpense',
              style: TextStyle(
                fontSize: 24, // Adjust the font size as needed
                fontWeight: FontWeight.bold, // Make the text bold
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail Trip',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<TripDetailProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (provider.hasError) {
                      print('Error : ${provider.error}');
                      return Center(child: Text('Error: ${provider.error}'));
                    } else {
                      // Tambahkan penanganan untuk nilai null
                      if (provider.data != null) {
                        // Data perjalanan tersedia, lanjutkan dengan menampilkan widget
                        TripDetailModel trip = provider.data!;
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Trip ID: ${trip.tripId}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: trip.statusId == 2
                                        ? Color(0xFFEBA794)
                                        : Color(0xFFD1BFFF),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    trip.statusId == 2
                                        ? "In Progress"
                                        : "Approved",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text('Submitted By',
                                          style: TextStyle(fontSize: 14)),
                                      Text('${trips.staffName}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      Text('Location',
                                          style: TextStyle(fontSize: 14)),
                                      Text('${trip.location}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      Text('Trip Date',
                                          style: TextStyle(fontSize: 14)),
                                      Text(
                                          '${dateFormat.format(trip.startDate)} - ${dateFormat.format(trip.endDate)}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      Text('Total Cost',
                                          style: TextStyle(fontSize: 14)),
                                      Text('\$${trip.totalCost}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        // Penanganan saat data perjalanan null
                        return Center(child: Text('No trip data available'));
                      }
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            //List Expense
            Text(
              'Expense Items',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            SizedBox(height: 10),
            Expanded(
              child: Consumer<ExpenseListProvider>(
                  builder: (context, provider, child) {
                if (provider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (provider.hasError) {
                  print('Error : ${provider.error}');
                  return Center(child: Text('Error: ${provider.error}'));
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: provider.data.length,
                        itemBuilder: (context, index) {
                          final expense = provider.data[index];
                          return Card(
                            color: expense.isApproved == true
                                ? Color(0xFFE3F2FD)
                                : Color(0xFFFFCDD2),
                            child: ListTile(
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text('${expense.expenseType}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: expense.isApproved == true
                                          ? Colors.lightBlue
                                          : Colors.red,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      expense.isApproved == true
                                          ? 'Approved'
                                          : 'Reject',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Text('\$${expense.itemCost}'),
                              onTap: () {
                                // Handle onTap action
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExpenseDetailPage(
                                        expense: expense, statusTrip: trips.statusName,),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                  );
                }
              }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: trips.statusName == 'In Progress'
                    ? ElevatedButton(
                        onPressed: () async {
                          // Tampilkan dialog konfirmasi
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirmation'),
                                content: Text(
                                    'Are you sure you want to submit this trip? Once submitted, the data cannot be modified.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Tutup dialog
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      // Logika Approve
                                      try {
                                        // Panggil use case untuk menyetujui pengeluaran
                                        await _tripUseCase
                                            .submitTripApproval(trips.tripId);
                                        // Refresh trip data detail list
                                        Provider.of<TripDetailProvider>(context,
                                                listen: false)
                                            .refreshData(trips.tripId);
                                        // Refresh trip list detail list when back to the list
                                        Provider.of<TripProvider>(context,
                                                listen: false)
                                            .refreshData();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Trip submitted successfully'),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      } catch (e) {
                                        // Tangani kesalahan jika diperlukan
                                        print('Error approving expense: $e');
                                      }
                                      Navigator.of(context)
                                          .pop(); // Tutup dialog
                                    },
                                    child: Text('Submit'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        child: Text(
                          'Submit Trip Approval',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      )
                    : SizedBox.shrink(),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
