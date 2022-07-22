import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:laradesk_flutter/controllers/get_user.dart';
import 'package:laradesk_flutter/controllers/delete_user.dart';

class UserPage extends StatefulWidget {
  const UserPage({
    Key? key,
  }) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final myTitle = TextEditingController();

  File? _image;
  PickedFile? _pickedFile;
  final _picker = ImagePicker();

  Future<void> _getImage() async {
    _pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      setState(() {
        _image = File(_pickedFile!.path);
      });
    } else {
      print('image: $_image');
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    if (args['id'] == null) {
      return const Center(
        child: Text('No ticket id provided'),
      );
    } else {
      final user = getUser(args['id'] ?? '');

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xFF094074),
          elevation: 0,
          title: Text(
            "User - ${args['id']}",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Column(
          children: [
            FutureBuilder(
                builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!['id'] != null) {
                      return Center(
                        child: Column(
                          children: [
                            const Padding(padding: EdgeInsets.all(10)),
                            CircleAvatar(
                              backgroundColor: Colors.blue,
                              backgroundImage: NetworkImage(
                                  "https://34.140.17.43${snapshot.data!['avatar']}"),
                              radius: 100,
                            ),
                            const Padding(padding: EdgeInsets.all(10)),
                            Text(
                                "Name : ${snapshot.data!['last_name'].toUpperCase()} ${snapshot.data!['first_name']}"),
                            Text("Email : ${snapshot.data!['email']}"),
                            const Padding(padding: EdgeInsets.all(10)),
                            snapshot.data!['roles'].length > 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          "Roles : ${snapshot.data!['roles'].map((role) => role['name']).toList().join(', ')}"),
                                    ],
                                  )
                                : const Text("No role"),
                            const Padding(padding: EdgeInsets.all(10)),
                            Text(
                                "Created date : ${DateFormat('dd MMMM yyyy').format(DateTime.parse(snapshot.data!['created_at']))}"),
                            ElevatedButton(
                                child: const Text('Delete'),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red),
                                onPressed: () {
                                  showAlertDialog(context, snapshot);
                                }),
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('No User found'),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
                future: user),
          ],
        ),
      );
    }
  }
}

Widget ticketContentTile(
    String text, String date, String author, String avatar, context) {
  return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      child: InkWell(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              backgroundImage: NetworkImage("https://34.140.17.43$avatar"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '$author - $date',
                    style: const TextStyle(fontSize: 15.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.5),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        text.replaceAll('<br />', '\n'),
                        style: const TextStyle(fontSize: 13.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        onTap: () {},
      ));
}

showAlertDialog(BuildContext context, dynamic snapshot) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: const Text("No"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: const Text("Yes"),
    onPressed: () {
      deleteUser(snapshot.data!['id'].toString());
      Navigator.of(context).pop();
      Navigator.of(context).pop(true);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Waning"),
    content: const Text("Are you sure you want to delete this user?"),
    actions: [
      continueButton,
      cancelButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
