import 'dart:io';
import 'package:flutter/material.dart';
import 'package:laradesk_flutter/routes.dart';

import 'models/preferences.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await beforeLaunch();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Preferences2.getHomepage(),
      routes: appRoutes,
    );
  }
}

Future beforeLaunch() async {
  await Preferences2.init();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
