import 'dart:io';

import 'package:http/http.dart' as http;

import '../main.dart';

getdata() async {
  HttpOverrides.global = MyHttpOverrides();

  final response = await http.get(
    Uri.parse('https://34.140.17.43/api/dashboard'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization':
          "Q6MCkQSw3vCRk2EzroOhMVjvnCfl4PxXbOvmTPrrXyeEMXXZPfyG2ZZsYanb",
    },
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return response.body;
  } else {
    return "";
  }
}
