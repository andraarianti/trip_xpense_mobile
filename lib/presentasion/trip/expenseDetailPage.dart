import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trip_xpense/data/models/expense_model.dart';
import 'package:trip_xpense/domain/entities/expense_entity.dart';
import 'package:trip_xpense/presentasion/provider/expense_detail_provider.dart';

import '../../data/models/auth/login_model.dart';
import '../../domain/usecase/approval_usecase.dart';
import '../provider/expense_list_provider.dart';

class ExpenseDetailPage extends StatelessWidget {
  final int expenseId;
  final ApprovalUseCase _approvalUseCase = ApprovalUseCase();

  ExpenseDetailPage({Key? key, required this.expenseId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExpenseDetailProvider>(context, listen: false)
          .refreshData(expenseId);
    });

    int? approverId;
    final Box<LoginResponse> box = Hive.box('loginBox');

    final LoginResponse? staff = box.getAt(0);
    approverId = staff?.staffId;

    final dateFormat = DateFormat('dd MMMM yyyy');

    return Scaffold(
        appBar: AppBar(
          title: Text('Expense Detail'),
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
                                  onPressed: () async {
                                    // Logika Approve
                                    try {
                                      // Panggil use case untuk menyetujui pengeluaran
                                      await _approvalUseCase.approveExpense(expense.expenseId, approverId!);
                                      // Refresh expense list
                                      Provider.of<ExpenseDetailProvider>(context, listen: false).refreshData(expense.expenseId);
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
                                      // Lakukan sesuatu setelah pengeluaran disetujui
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
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }
}
