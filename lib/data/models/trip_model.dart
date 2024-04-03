class TripModel {
  final int tripId;
  final int submittedBy;
  final String location;
  final double totalCost;
  final String startDate;
  final String endDate;
  final String statusName;
  final String staffName;

  TripModel({
    required this.tripId,
    required this.submittedBy,
    required this.location,
    required this.totalCost,
    required this.startDate,
    required this.endDate,
    required this.statusName,
    required this.staffName,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      tripId: json['TripId'],
      submittedBy: json['SubmittedBy'],
      location: json['Location'],
      totalCost: json['TotalCost'],
      startDate: json['StartDate'],
      endDate: json['EndDate'],
      statusName: json['StatusName'],
      staffName: json['StaffName'],
    );
  }

  Map<String,dynamic> toJson() {
    return{
      'TripId' : tripId,
      'SubmittedBy' : submittedBy,
      'Location' : location,
      'TotalCost' : totalCost,
      'StartDate' : startDate,
      'EndDate' : endDate,
      'StatusName' : statusName,
      'StaffName' : staffName
    };
  }


}
