import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

Future<Map> updateTicket(String ticketId, Map ticket) async {
  FlutterSecureStorage? secureStorage;
  String? apiToken;

  secureStorage = const FlutterSecureStorage();
  apiToken = await secureStorage.read(key: 'apiToken');

  HttpOverrides.global = MyHttpOverrides();
  ticket['_method'] = 'put';
  final response = await http.post(
    Uri.parse('https://34.140.17.43/api/ticket/$ticketId'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': '$apiToken',
    },
    body: json.encode(ticket),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return {};
  }
}
