import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trip_xpense/data/models/trip_model.dart';
import 'package:trip_xpense/domain/entities/expense_entity.dart';
import 'package:trip_xpense/domain/usecase/expense_usecase.dart';
import 'package:trip_xpense/domain/usecase/trip_usecase.dart';
import 'package:trip_xpense/presentasion/provider/expense_list_provider.dart';
import 'package:trip_xpense/presentasion/provider/trip_provider.dart';
import 'package:trip_xpense/presentasion/trip/expenseDetailPage.dart';

import '../../domain/entities/trip_entity.dart';

class TripDetailPage extends StatelessWidget {
  final TripModel trip;
  final TripUseCase _tripUseCase = TripUseCase();

  TripDetailPage({Key? key, required this.trip, required }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExpenseListProvider>(context, listen: false)
          .refreshData(trip.tripId);
    });

    final dateFormat = DateFormat('dd MMMM yyyy');

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
          'Trip Detail',
          style: TextStyle(
            fontSize: 24, // Adjust the font size as needed
            fontWeight: FontWeight.bold, // Make the text bold
            color: Colors.white, // Set the text color to white
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Trip ID: ${trip.tripId}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: trip.statusName == "In Progress"
                          ? Colors.green
                          : Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      trip.statusName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Submitted By: ${trip.staffName}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Location: ${trip.location}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Total Cost: \$${trip.totalCost}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Expense Items',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
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
                              subtitle: Text('${expense.itemCost}'),
                              onTap: () {
                                // Handle onTap action
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExpenseDetailPage(
                                        expense: expense, statusTrip: trip.statusName,),
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
                child: trip.statusName == 'In Progress'
                    ? ElevatedButton(
                  onPressed: () async {
                    // Tampilkan dialog konfirmasi
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirmation'),
                          content: Text('Are you sure you want to submit this trip? Once submitted, the data cannot be modified.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Tutup dialog
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                // Logika Approve
                                try {
                                  // Panggil use case untuk menyetujui pengeluaran
                                  await _tripUseCase.submitTripApproval(trip.tripId);
                                  // Refresh expense list
                                  Provider.of<TripProvider>(context, listen: false)
                                      .refreshData();
                                } catch (e) {
                                  // Tangani kesalahan jika diperlukan
                                  print('Error approving expense: $e');
                                }
                                Navigator.of(context).pop(); // Tutup dialog
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
