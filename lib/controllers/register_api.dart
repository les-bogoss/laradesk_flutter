import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../main.dart';

register(String password, String email, String confirmPassword,
    String firstName, String lastName) async {
  HttpOverrides.global = MyHttpOverrides();

  final response = await http.post(
    Uri.parse('https://34.140.17.43/api/register'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: json.encode({
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
    }),
  );
  if (response.statusCode == 201) {
    return [true, json.decode(response.body)['api_token'].toString()];
  } else {
    Map<String, dynamic> jsonData = json.decode(response.body);

    Map<String, dynamic> errors = jsonData['errors'];

    String errorMessage = "";
    errors.forEach((key, value) {
      errorMessage += value[0] + "\n";
    });
    return [false, errorMessage];
  }
}
