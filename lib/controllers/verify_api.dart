import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../main.dart';

gettoken(String password, String email) async {
  HttpOverrides.global = MyHttpOverrides();

  final response = await http.post(
    Uri.parse('https://34.140.17.43/api/login'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'email': email,
      'password': password,
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return json.decode(response.body)['api_token'].toString();
  } else {
    return "";
  }
}
