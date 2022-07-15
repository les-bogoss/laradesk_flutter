import 'package:flutter/material.dart';


class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0, 4),
          end: Alignment.topCenter,
          colors: [Color(0xFF5ADBFF), Colors.white],
        ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Text('RegisterPage'),
        ),
      ),
    );
  }
}
