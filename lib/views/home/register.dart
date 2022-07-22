import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laradesk_flutter/controllers/register_api.dart';

import '../../models/preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final myEmail = TextEditingController();
  final myFirstName = TextEditingController();
  final myLastName = TextEditingController();
  final myPassword = TextEditingController();
  final myConfirmPassword = TextEditingController();

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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 350,
                height: 550,
                child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'SIGN UP',
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 50,
                                          color: const Color(0xFF094074))),
                                ],
                              ),
                            ),
                          ),
                          TextField(
                            controller: myEmail,
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF094074),
                                  width: 2,
                                ),
                              ),
                              labelText: 'Email',
                              labelStyle:
                                  const TextStyle(color: Color(0xFF094074)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3,
                                    color: Color(0xFF094074),
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(children: [
                              Expanded(
                                child: TextField(
                                  controller: myFirstName,
                                  decoration: InputDecoration(
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF094074),
                                        width: 2,
                                      ),
                                    ),
                                    labelText: 'First Name',
                                    labelStyle: const TextStyle(
                                        color: Color(0xFF094074)),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 3,
                                          color: Color(0xFF094074),
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: myLastName,
                                  decoration: InputDecoration(
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF094074),
                                        width: 2,
                                      ),
                                    ),
                                    labelText: 'Last Name',
                                    labelStyle: const TextStyle(
                                        color: Color(0xFF094074)),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 3,
                                          color: Color(0xFF094074),
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          TextField(
                            obscureText: true,
                            controller: myPassword,
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF094074),
                                  width: 2,
                                ),
                              ),
                              labelText: 'Password',
                              labelStyle:
                                  const TextStyle(color: Color(0xFF094074)),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3,
                                    color: Color(0xFF094074),
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            obscureText: true,
                            controller: myConfirmPassword,
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF094074),
                                  width: 2,
                                ),
                              ),
                              labelText: 'Confirm Password',
                              labelStyle:
                                  const TextStyle(color: Color(0xFF094074)),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3,
                                    color: Color(0xFF094074),
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: 140,
                            color: const Color.fromARGB(0, 0, 0, 0),
                            margin: const EdgeInsets.only(top: 0),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (myEmail.text.isNotEmpty &&
                                    myPassword.text.isNotEmpty &&
                                    myFirstName.text.isNotEmpty &&
                                    myLastName.text.isNotEmpty &&
                                    myConfirmPassword.text.isNotEmpty) {
                                  if (myPassword.text ==
                                      myConfirmPassword.text) {
                                    var response = await register(
                                        myPassword.text,
                                        myEmail.text,
                                        myConfirmPassword.text,
                                        myFirstName.text,
                                        myLastName.text);

                                    if (response[0] == false) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Error"),
                                              content:
                                                  Text(response[1].toString()),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text("OK"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                    } else {
                                      Preferences.setLoggedIn(
                                          context, false, "");

                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil('/login',
                                              (Route<dynamic> route) => false);
                                    }
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Error'),
                                          content: const Text(
                                              'Passwords doesn\'t match'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('Ok'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                  //save token to shared preferences

                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                            'Please fill all fields'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Ok'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color(0xFF094074)),
                                elevation:
                                    ButtonStyleButton.allOrNull<double>(2),
                                shape: MaterialStateProperty.resolveWith<
                                    OutlinedBorder>(
                                  (_) {
                                    return RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: const BorderSide(
                                            color: Color(0xFF094074),
                                            width: 4));
                                  },
                                ),
                              ),
                              child: Text(
                                'REGISTER',
                                style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil('/login',
                                            (Route<dynamic> route) => false);
                                  },
                                  child: Text(
                                    "Sign in",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: const Color(0xFFFFDD4A)),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
