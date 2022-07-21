import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Preferences {
  static FlutterSecureStorage? secureStorage;
  static String? apiToken;
  static bool loggedIn = false;

  static Future init() async {
    try {
      secureStorage = const FlutterSecureStorage();
      apiToken = await secureStorage?.read(key: 'apiToken');

      print("apiToken: is $apiToken");
      loggedIn = (apiToken != null);
    } catch (e) {
      throw Exception(e);
    }
  }

  static void setLoggedIn(
      BuildContext context, bool loggedIn, String? apiToken) {
    /* Simulatiuon du JWT récupéré depuis l'API */

    apiToken = apiToken ?? "";
    if (loggedIn) {
      loggedIn = true;
      secureStorage
          ?.write(key: 'apiToken', value: apiToken)
          .then((value) => {Navigator.pushNamed(context, '/')});
    } else {
      loggedIn = false;
      secureStorage
          ?.delete(key: 'apiToken')
          .then((value) => {Navigator.pushNamed(context, '/login')});
    }
  }

  static getHomepage() {
    if (apiToken != null) {
      return "/";
    } else {
      return '/unlogged';
    }
  }
}
