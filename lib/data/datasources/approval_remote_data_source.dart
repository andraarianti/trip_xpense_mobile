import 'dart:convert';

import 'package:http/http.dart' as http;

class ApprovalRemoteDataSource {
  final String Url = "https://app.actualsolusi.com/bsi/TripXpense/api";

  Future<void> approveExpense(int expenseId, int approverId) async {
    // Buat request body sesuai dengan format yang diberikan
    final Map<String, dynamic> requestBody = {
      "ExpenseID": expenseId,
      "ApproverID": approverId,
    };

    // Konversi request body menjadi JSON
    final String requestBodyJson = jsonEncode(requestBody);

    try {
      final response = await http.post(
        Uri.parse(Url + "/Approvals/Approved"),
        headers: {
          'Content-Type': 'application/json', // Atur tipe konten sebagai JSON
        },
        body: requestBodyJson,
      );

      if (response.statusCode == 200) {
        print("Expense id ${expenseId} approval request success");
      } else {
        print("Expense approval request failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Expense approval request failed: $e");
    }
  }

  Future<void> rejectExpense(int expenseId, int approverId) async {
    // Buat request body sesuai dengan format yang diberikan
    final Map<String, dynamic> requestBody = {
      "ExpenseID": expenseId,
      "ApproverID": approverId,
    };

    // Konversi request body menjadi JSON
    final String requestBodyJson = jsonEncode(requestBody);

    try {
      final response = await http.post(
        Uri.parse(Url + "/Approvals/Rejected"),
        headers: {
          'Content-Type': 'application/json', // Atur tipe konten sebagai JSON
        },
        body: requestBodyJson,
      );

      if (response.statusCode == 200) {
        print("Expense id ${expenseId} rejected request success");
      } else {
        print("Expense approval request failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Expense approval request failed: $e");
    }
  }

}