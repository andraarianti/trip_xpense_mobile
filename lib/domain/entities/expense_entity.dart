class ExpenseEntity {
  final int expenseId;
  final int tripId;
  final String expenseType;
  final double itemCost;
  final String description;
  final String receiptImage;
  final DateTime lastModified;
  final bool isDeleted;
  final bool isApproved;

  ExpenseEntity({
    required this.expenseId,
    required this.tripId,
    required this.expenseType,
    required this.itemCost,
    required this.description,
    required this.receiptImage,
    required this.lastModified,
    required this.isDeleted,
    required this.isApproved,
  });
}
