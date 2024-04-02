import 'package:trip_xpense/data/datasources/approval_remote_data_source.dart';

class ApprovalRepository {
  var _remoteDataSource = ApprovalRemoteDataSource();

  Future<void> approveExpense(int expenseId, int approverId) async {
    try {
      await _remoteDataSource.approveExpense(expenseId, approverId);
      // Return something if necessary, or just leave it as void
    } catch (e) {
      // Handle errors if necessary
      throw e;
    }
  }

  Future<void> rejectExpense(int expenseId, int approverId) async {
    try {
      await _remoteDataSource.rejectExpense(expenseId, approverId);
      // Return something if necessary, or just leave it as void
    } catch (e) {
      // Handle errors if necessary
      throw e;
    }
  }
}
