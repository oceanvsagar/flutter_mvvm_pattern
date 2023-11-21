import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/utils.dart';

class APIService {
  Future<http.Response?> get(String url) async {
    try {
      final uri = Uri.parse(url);
      final headers = {'Content-Type': 'application/json'};
      try {
        var response = await http.get(uri, headers: headers);

        if (response.statusCode == 200) {
          Utils.print(
              "URL: $url output: ${response.statusCode} body -- ${response.body}  ");

          return response;
        } else {
          Utils.print(
              "URL: $url statusCode: ${response.statusCode} response body ${json.decode(response.body)}  ");
        }
      } catch (e) {
        Utils.print(e.toString());
      }

      return null;
    } on Exception catch (e) {
      Utils.printCrashError(e.toString());
      return null;
    }
  }
}
