import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

Future<List> getTicketContents(String id) async {
  FlutterSecureStorage? secureStorage;
  String? apiToken;

  secureStorage = const FlutterSecureStorage();
  apiToken = await secureStorage.read(key: 'apiToken');
  HttpOverrides.global = MyHttpOverrides();
  final response = await http.get(
    Uri.parse('https://34.140.17.43/api/ticket/$id/content'),
    headers: {
      'Accept': 'application/json',
      'Authorization': '$apiToken',
    },
  );

  if (response.statusCode == 200) {
    return json.decode(response.body)["ticket"];
  } else {
    return [];
  }
}
