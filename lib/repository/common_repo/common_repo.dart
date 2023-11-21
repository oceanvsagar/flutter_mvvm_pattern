import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../api/api_io.dart';
import '../../api/http_web_service.dart';
import '../../utils/utils.dart';

abstract class CommonRepository {
  Future<List<Doctor?>?> getDoctorDetails(String? url);
  Future<ServiceOptions?> getPackageDetails(String? url);
  Future<ConfirmationDetails?> getConfirmationDetails(String? url);
  Future<List<BookingDetails?>?> getBookingDetails(String? url);
}

class CommonRepositoryImpl implements CommonRepository {
  @override
  Future<List<Doctor?>?> getDoctorDetails(String? url) async {
    List<Doctor> doctorDetails = [];
    final response = await APIService().get(url!);
    if (response?.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response!.body);

      for (var item in jsonData) {
        doctorDetails.add(Doctor.fromJson(item));
      }

      Utils.print("URL: $url output: ${response.statusCode} body -- ${response.body} Doctors: ${doctorDetails.toString()}");
      return doctorDetails;
    } else {
      // Handle the error case here, e.g., return null or throw an exception.
      // You can customize this part based on your error handling logic.
      return null;
    }
  }

  @override
  Future<ServiceOptions?> getPackageDetails(String? url) async {
    List<ServiceOptions> packageDetails = [];
    final response = await APIService().get(url!);
    if (response?.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response!.body);
      return ServiceOptions.fromJson(jsonData);
    } else {
      // Handle the error case here, e.g., return null or throw an exception.
      // You can customize this part based on your error handling logic.
      return null;
    }
  }

  @override
  Future<ConfirmationDetails?> getConfirmationDetails(String? url) async {
    final response = await APIService().get(url!);
    if (response?.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response!.body);
      return ConfirmationDetails.fromJson(jsonData);
    } else {
      return null;
    }
  }

  @override
  Future<List<BookingDetails?>?> getBookingDetails(String? url) async {
    List<BookingDetails> bookingDetails = [];
    final response = await APIService().get(url!);
    if (response?.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response!.body);

      for (var item in jsonData) {
        bookingDetails?.add(BookingDetails.fromJson(item));
      }
    }
    return bookingDetails;

  }
}
