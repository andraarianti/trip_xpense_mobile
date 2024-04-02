import '../../data/repositories/approval_repository.dart';

class ApprovalUseCase {
  var _repository = ApprovalRepository();

  Future<void> approveExpense(int expenseId, int approverId) async {
    try {
      await _repository.approveExpense(expenseId, approverId);
    } catch (e) {
      // Tangani kesalahan jika perlu
      throw e;
    }
  }

  Future<void> rejectExpense(int expenseId, int approverId) async {
    try {
      await _repository.rejectExpense(expenseId, approverId);
    } catch (e) {
      // Tangani kesalahan jika perlu
      throw e;
    }
  }
}
