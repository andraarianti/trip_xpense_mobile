import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trip_xpense/domain/entities/expense_entity.dart';
import 'package:trip_xpense/domain/usecase/expense_usecase.dart';
import 'package:trip_xpense/presentasion/trip/expenseDetailPage.dart';

import '../../domain/entities/trip_entity.dart';

class TripDetailPage extends StatelessWidget {
  final TripEntity trip;
  final ExpenseUseCase _expenseUseCase = ExpenseUseCase();

  TripDetailPage({Key? key, required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<ExpenseEntity>> _expenseListFuture = _expenseUseCase
        .getExpenseByTripId(trip.tripId)
        .then((expenseList) {
      return expenseList.map((expenseModel) {
        return _expenseUseCase.mapToEntity(expenseModel);
      }).toList();
    }).catchError((error) {
      // Handle error here
      print('Error fetching trip list: $error');
      return <ExpenseEntity>[];
    });

    final dateFormat = DateFormat('dd MMMM yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Detail'),
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: trip.statusName == "In Progress" ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      trip.statusName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
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
                      Text(
                        'Trip Date: ${dateFormat.format(trip.startDate)} - ${dateFormat.format(trip.endDate)}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text(
              'Expense Items',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<ExpenseEntity>>(
                future: _expenseListFuture,
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
                  else{
                    final expenseList = snapshot.data!;
                    return ListView.builder(
                        itemCount: expenseList.length,
                        itemBuilder: (context, index){
                          final expense = expenseList[index];
                          return Card(
                            color: expense.isApproved == true ?  Color(0xFFE3F2FD) : Color(0xFFFFCDD2),
                            child: ListTile(
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                        '${expense.expenseType}',
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: expense.isApproved == true ? Colors.lightBlue : Colors.red,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      expense.isApproved == true ? 'Approved' : 'Reject',
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
                                    builder: (context) => ExpenseDetailPage(expense: expense),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                    );
                  }
                },
              ),
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
                child: ElevatedButton(
                  onPressed: (){

                  },
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  child: Text(
                    'Submit Trip Approval',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}
