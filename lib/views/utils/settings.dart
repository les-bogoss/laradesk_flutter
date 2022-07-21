import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laradesk_flutter/models/preferences.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF094074),
        elevation: 0,
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Preferences.setLoggedIn(context, false, null);
            },
            child: const Text('Logout')),
      ),
    );
  }
}
