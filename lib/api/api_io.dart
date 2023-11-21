class Doctor {
  String doctorName  = "";
  String image  = "";
  String speciality  = "";
  String location  = "";
  int patientsServed  = 0;
  int yearsOfExperience  = 0;
  double rating  = 0.0;
  int numberOfReviews = 0;
  Map<String, List<String>> availability = {};

  Doctor.fromJson(Map<String, dynamic> json) {
      doctorName = json['doctor_name'];
      image = json['image'];
      speciality = json['speciality'];
      location = json['location'];
      patientsServed = json['patients_served'];
      yearsOfExperience = json['years_of_experience'];
      rating = json['rating'].toDouble();
      numberOfReviews = json['number_of_reviews'];
      availability = Map<String, List<String>>.from(
        json['availability'].map((key, value) => MapEntry<String, List<String>>(key, List<String>.from(value))),
      );
  }
}

class ServiceOptions {
  final List<String> duration;
  final List<String> package;

  ServiceOptions({required this.duration, required this.package});

  factory ServiceOptions.fromJson(Map<String, dynamic> json) {
    final List<dynamic> durationList = json['duration'];
    final List<String> duration = durationList.map((value) => value.toString()).toList();

    final List<dynamic> packageList = json['package'];
    final List<String> package = packageList.map((value) => value.toString()).toList();

    return ServiceOptions(duration: duration, package: package);
  }
}

class ConfirmationDetails{
  String doctorName  = "";
  String appointmentDate  = "";
  String appointmentTime  = "";
  String location  = "";
  String appointmentPackage  = "";

  ConfirmationDetails.fromJson(Map<String, dynamic> json) {
    doctorName = json['doctor_name'];
    appointmentDate = json['appointment_date'];
    appointmentTime = json['appointment_time'];
    location = json['location'];
    appointmentPackage = json['appointment_package'];
  }
}

class BookingDetails{
  String bookingId  = "";
  String doctorName  = "";
  String location  = "";
  String appointmentDate  = "";
  String appointmentTime  = "";

  BookingDetails.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    doctorName = json['doctor_name'];
    location = json['location'];
    appointmentDate = json['appointment_date'];
    appointmentTime = json['appointment_time'];
  }
}




