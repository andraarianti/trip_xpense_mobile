import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trip_xpense/domain/entities/expense_entity.dart';

class ExpenseDetailPage extends StatelessWidget {
  final ExpenseEntity expense;

  const ExpenseDetailPage({Key? key, required this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMMM yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Expense Type: ${expense.expenseType}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Item Cost: ${expense.itemCost}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Description: ${expense.description}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Last Modified: ${dateFormat.format(expense.lastModified)}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Status: ${expense.isApproved ? 'Approved' : 'Reject'}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Spacer(), // Spacer untuk menempatkan tombol di bagian bawah
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (!expense.isApproved)
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          // Foreground color
                          foregroundColor: Colors.white, backgroundColor: Colors.lightBlueAccent,
                        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                        onPressed: () {
                          // Logika Approve
                        },
                        label: const Text('Approved'),
                        icon: const Icon(Icons.check)
                      ),
                    if (expense.isApproved)
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          // Foreground color
                          foregroundColor: Colors.white, backgroundColor: Colors.redAccent,
                        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                        onPressed: () {
                          // Logika Reject
                        },
                          label: const Text('Reject'),
                          icon: const Icon(Icons.cancel)
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}