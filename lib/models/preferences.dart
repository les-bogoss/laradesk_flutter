import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? prefs;
  static bool loggedIn = false;
  static String? token;

  static Future init() async {
    prefs = await SharedPreferences.getInstance();
    loggedIn = prefs?.getBool('loggedIn') ?? false;
  }

  static void setLoggedIn(BuildContext context, bool value) {
    loggedIn = value;
    prefs?.setBool('loggedIn', value);

    if (loggedIn) {
      Navigator.pushNamed(context, '/tickets');
    } else {
      Navigator.pushNamed(context, '/');
    }
  }

  static String getHomepage() {
    if (loggedIn) {
      return '/tickets';
    } else {
      return '/';
    }
  }
}
