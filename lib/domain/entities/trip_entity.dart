class TripEntity {
  final int tripId;
  final int submittedBy;
  final String location;
  final double totalCost;
  final DateTime startDate;
  final DateTime endDate;
  final String statusName;
  final String staffName;

  TripEntity({
    required this.tripId,
    required this.submittedBy,
    required this.location,
    required this.totalCost,
    required this.startDate,
    required this.endDate,
    required this.statusName,
    required this.staffName,
  });
}
