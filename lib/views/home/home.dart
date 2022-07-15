import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
              const Spacer(flex: 3),
              Column(
                children: [
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'LARA',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w200,
                                fontSize: 50,
                                color: const Color(0xFF094074))),
                        TextSpan(
                          text: 'DESK',
                          style: GoogleFonts.montserrat(
                              fontSize: 50,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF094074)),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 90, right: 90, bottom: 5),
                    child: Divider(
                      color: Color(0xFF094074),
                      thickness: 0.8,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  'LARADESK is a simple and intuitive ticketing solution build with Laravel 9 by a passionate team of student developpers !',
                              style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF3C6997))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 120,
                    margin: const EdgeInsets.only(top: 0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF094074)),
                        elevation: ButtonStyleButton.allOrNull<double>(2),
                        shape:
                            MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (_) {
                            return RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            );
                          },
                        ),
                      ),
                      child: Text(
                        'SIGNUP',
                        style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    width: 120,
                    color: const Color.fromARGB(0, 0, 0, 0),
                    margin: const EdgeInsets.only(top: 0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        elevation: ButtonStyleButton.allOrNull<double>(2),
                        shape:
                            MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (_) {
                            return RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                    color: Color(0xFF094074), width: 4));
                          },
                        ),
                      ),
                      child: Text(
                        'LOGIN',
                        style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF094074)),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 2),
              // add container
            ],
          ),
        ),
      ),
    );
  }
}
