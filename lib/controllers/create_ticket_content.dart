import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

Future<Map> createTicketContent(
    String ticketId, String? text, Uint8List? image) async {
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
      'content_type': 'image',
      'text': text,
      'file': base64.encode(image!),
    }),
  );

  if (response.statusCode == 201) {
    return json.decode(response.body);
  } else {
    print(response.body);
    return {};
  }
}
