class ExpenseModel {
  final int expenseId;
  final int tripId;
  final String expenseType;
  final double itemCost;
  final String description;
  final String receiptImage;
  final DateTime lastModified;
  final bool isDeleted;
  final bool isApproved;

  ExpenseModel({
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

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      expenseId: json['ExpenseID'],
      tripId: json['TripID'],
      expenseType: json['ExpenseType'],
      itemCost: json['ItemCost'].toDouble(),
      description: json['Description'],
      receiptImage: json['ReceiptImage'],
      lastModified: DateTime.parse(json['LastModified']),
      isDeleted: json['IsDeleted'],
      isApproved: json['IsApproved'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ExpenseID': expenseId,
      'TripID': tripId,
      'ExpenseType': expenseType,
      'ItemCost': itemCost,
      'Description': description,
      'ReceiptImage': receiptImage,
      'LastModified': lastModified.toIso8601String(),
      'IsDeleted': isDeleted,
      'IsApproved': isApproved,
    };
  }
}
