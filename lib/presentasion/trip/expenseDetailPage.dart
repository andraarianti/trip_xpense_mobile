import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:trip_xpense/data/models/expense_model.dart';
import 'package:trip_xpense/presentasion/provider/expense_detail_provider.dart';
import 'package:trip_xpense/presentasion/provider/trip_detail_provider.dart';
import '../../data/models/auth/login_model.dart';
import '../../domain/usecase/approval_usecase.dart';
import '../provider/expense_list_provider.dart';

class ExpenseDetailPage extends StatelessWidget {
  final ExpenseModel expense;
  final String statusTrip;
  final ApprovalUseCase _approvalUseCase = ApprovalUseCase();

  ExpenseDetailPage({Key? key, required this.expense, required this.statusTrip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExpenseDetailProvider>(context, listen: false)
          .refreshData(expense.expenseId);
      Provider.of<TripDetailProvider>(context, listen: false)
          .refreshData(expense.tripId);
      Provider.of<ExpenseListProvider>(context, listen: false)
          .refreshData(expense.tripId);
    });

    int? approverId;
    final Box<LoginResponse> box = Hive.box('loginBox');

    final LoginResponse? staff = box.getAt(0);
    approverId = staff?.staffId;

    //final dateFormat = DateFormat('dd MMMM yyyy');

    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
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
            'Expense Detail',
            style: TextStyle(
              fontSize: 24, // Adjust the font size as needed
              fontWeight: FontWeight.bold, // Make the text bold
              color: Colors.white, // Set the text color to white
            ),
          ),
        ),
        body: Consumer<ExpenseDetailProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (provider.hasError) {
              print('Error : ${provider.error}');
              return Center(child: Text('Error: ${provider.error}'));
            } else {
              final ExpenseModel? expense = provider.data;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Expense Type: ${expense?.expenseType}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Item Cost: ${expense?.itemCost}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Description: ${expense?.description}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Status: ${expense!.isApproved ? 'Approved' : 'Reject'}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Spacer(), // Spacer untuk menempatkan tombol di bagian bawah

                    statusTrip == 'In Progress' ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (!expense.isApproved)
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    // Foreground color
                                    foregroundColor: Colors.white, backgroundColor: Colors.lightBlueAccent,
                                  ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                                  onPressed: () async {
                                    // Logika Approve
                                    try {
                                      // Panggil use case untuk menyetujui pengeluaran
                                      await _approvalUseCase.approveExpense(expense.expenseId, approverId!);
                                      // Refresh expense list
                                      Provider.of<ExpenseDetailProvider>(context, listen: false).refreshData(expense.expenseId);
                                      Provider.of<TripDetailProvider>(context, listen: false).refreshData(expense.tripId);
                                      Provider.of<ExpenseListProvider>(context, listen: false).refreshData(expense.tripId);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Expense Status Successfully Change'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    } catch (e) {
                                      // Tangani kesalahan jika diperlukan
                                      print('Error approving expense: $e');
                                    }
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
                                  onPressed: () async {
                                    // Logika Reject
                                    try {
                                      // Panggil use case untuk menyetujui pengeluaran
                                      await _approvalUseCase.rejectExpense(expense.expenseId, approverId!);
                                      Provider.of<ExpenseDetailProvider>(context, listen: false).refreshData(expense.expenseId);
                                      Provider.of<TripDetailProvider>(context, listen: false).refreshData(expense.tripId);
                                      Provider.of<ExpenseListProvider>(context, listen: false).refreshData(expense.tripId);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Expense Status Successfully Change'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    } catch (e) {
                                      // Tangani kesalahan jika diperlukan
                                      print('Error approving expense: $e');
                                    }
                                  },
                                  label: const Text('Reject'),
                                  icon: const Icon(Icons.cancel)
                              ),
                          ],
                        ),
                      ),
                    ) : SizedBox.shrink(),
                  ],
                ),
              );
            }
          },
        ));
  }
}
