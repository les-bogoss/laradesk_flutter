import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laradesk_flutter/controllers/verify_api.dart';
import '../../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final myEmail = TextEditingController();
  final myPassword = TextEditingController();

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
                width: 300,
                height: 400,
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'LOGIN',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 50,
                                        color: const Color(0xFF094074))),
                              ],
                            ),
                          ),
                          TextField(
                            controller: myEmail,
                            decoration: InputDecoration(
                              labelText: 'Email',
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
                            height: 50,
                          ),
                          TextField(
                            obscureText: true,
                            controller: myPassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
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
                            height: 50,
                          ),
                          Container(
                            width: 120,
                            color: const Color.fromARGB(0, 0, 0, 0),
                            margin: const EdgeInsets.only(top: 0),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (myEmail.text.isNotEmpty &&
                                    myPassword.text.isNotEmpty) {
                                  //save token to shared preferences
                                  var apiToken = await gettoken(
                                      myPassword.text, myEmail.text);
                                  if (apiToken.isEmpty) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Error'),
                                          content: const Text(
                                              'Invalid email or password'),
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
                                  } else {
                                    await storage.write(
                                        key: 'api_token', value: apiToken);
                                    Navigator.pushNamed((context), '/tickets');
                                  }
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
                                'LOGIN',
                                style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: Text("Don't have an account? Sign up",
                                style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF094074))),
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
