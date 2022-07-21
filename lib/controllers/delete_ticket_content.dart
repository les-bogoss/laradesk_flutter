import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../models/preferences.dart';

Future<Map> deleteContent(String ticketId, String contentId) async {
  HttpOverrides.global = MyHttpOverrides();
  final response = await http.delete(
    Uri.parse('https://34.140.17.43/api/ticket/$ticketId/content/$contentId'),
    headers: {
      'Accept': 'application/json',
      'Authorization': '${Preferences.token}',
    },
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return {};
  }
}
