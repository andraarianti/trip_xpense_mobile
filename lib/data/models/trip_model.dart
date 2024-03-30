class TripModel {
  final int tripId;
  final int submittedBy;
  final String location;
  final String startDate;
  final String endDate;
  final int statusId;
  final String statusName;
  final String staffName;

  TripModel({
    required this.tripId,
    required this.submittedBy,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.statusId,
    required this.statusName,
    required this.staffName,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      tripId: json['TripId'],
      submittedBy: json['SubmittedBy'],
      location: json['Location'],
      startDate: json['StartDate'],
      endDate: json['EndDate'],
      statusId: json['StatusId'],
      statusName: json['StatusName'],
      staffName: json['StaffName'],
    );
  }

  Map<String,dynamic> toJson() {
    return{
      'TripId' : tripId,
      'SubmittedBy' : submittedBy,
      'Location' : location,
      'StartDate' : startDate,
      'EndDate' : endDate,
      'StatusId' : statusId,
      'StatusName' : statusName,
      'StaffName' : staffName
    };
  }
}
