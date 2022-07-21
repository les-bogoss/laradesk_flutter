import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

getdata() async {
  FlutterSecureStorage? secureStorage;
  String? apiToken;

  secureStorage = const FlutterSecureStorage();
  apiToken = await secureStorage.read(key: 'apiToken');
  HttpOverrides.global = MyHttpOverrides();

  final response = await http.get(
    Uri.parse('https://34.140.17.43/api/dashboard'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': '$apiToken',
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
