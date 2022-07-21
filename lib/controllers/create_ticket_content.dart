import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

Future<Map> createTicketContent(String ticketId, String text) async {
  FlutterSecureStorage? secureStorage;
  String? apiToken;

  secureStorage = const FlutterSecureStorage();
  apiToken = await secureStorage.read(key: 'apiToken');
  HttpOverrides.global = MyHttpOverrides();
  final response = await http.post(
    Uri.parse('https://34.140.17.43/api/ticket/$ticketId/content'),
    headers: {
      'Authorization': '$apiToken',
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'content_type': 'text',
      'text': text,
    }),
  );

  if (response.statusCode == 201) {
    return json.decode(response.body);
  } else {
    return {};
  }
}
