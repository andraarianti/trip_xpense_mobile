class TripEntity {
  final int tripId;
  final int submittedBy;
  final String location;
  final DateTime startDate;
  final DateTime endDate;
  final int statusId;
  final String statusName;
  final String staffName;

  TripEntity({
    required this.tripId,
    required this.submittedBy,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.statusId,
    required this.statusName,
    required this.staffName,
  });
}
