import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../models/preferences.dart';

Future<Map> updateTicket(String ticketId, Map ticket) async {
  HttpOverrides.global = MyHttpOverrides();
  ticket['_method'] = 'put';
  final response = await http.post(
    Uri.parse('https://34.140.17.43/api/ticket/$ticketId'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': '${Preferences.token}',
    },
    body: json.encode(ticket),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return {};
  }
}
