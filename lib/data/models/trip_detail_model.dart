class TripDetailModel {
  final int tripId;
  final int submittedBy;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final int statusId;
  final double totalCost;
  final DateTime lastModified;
  final bool isDeleted;

  TripDetailModel({
    required this.tripId,
    required this.submittedBy,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.statusId,
    required this.totalCost,
    required this.lastModified,
    required this.isDeleted,
  });

  factory TripDetailModel.fromJson(Map<String, dynamic> json) {
    return TripDetailModel(
      tripId: json['TripID'] ?? 0,
      submittedBy: json['SubmittedBy'] ?? '',
      startDate: DateTime.parse(json['StartDate'] ?? ''),
      endDate: DateTime.parse(json['EndDate'] ?? ''),
      location: json['Location'] ?? '',
      statusId: json['StatusID'] ?? 0,
      totalCost: json['TotalCost'] ?? 0.0,
      lastModified: DateTime.parse(json['LastModified'] ?? ''),
      isDeleted: json['IsDeleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TripId': tripId,
      'SubmittedBy': submittedBy,
      'StartDate' : startDate,
      'EndDate' : endDate,
      'Location' : location,
      'StatusId' : statusId,
      'TotalCost' : totalCost,
      'LastModified' : lastModified,
      'IsDeleted' : isDeleted
    };
  }
}
