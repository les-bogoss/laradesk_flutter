import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:laradesk_flutter/controllers/create_ticket_content.dart';
import 'package:laradesk_flutter/controllers/get_ticket.dart';
import 'package:laradesk_flutter/controllers/get_ticket_content.dart';
import 'package:laradesk_flutter/controllers/delete_ticket_content.dart';

import '../../controllers/update_ticket.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
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
      final ticket = getTicket(args['id'] ?? '');
      var ticketContents = getTicketContents(args['id'] ?? '');

      const prioritys = [
        '1',
        '2',
        '3',
      ];
      const status = [
        'OUVERT',
        'ATTRIBUÉ',
        'ATTENTE REPONSE',
        'CLOS',
        'RÉSOLU',
      ];
      const ratings = [
        'N/A',
        '1',
        '2',
        '3',
      ];

      Future<void> refresh() async {
        setState(() {
          ticketContents = getTicketContents(args['id'] ?? '');

          return;
        });
      }

      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: const Color(0xFF094074),
            elevation: 0,
            title: Text(
              "Ticket - ${args['id']}",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: refresh,
            child: Column(
              children: [
                FutureBuilder(
                    builder:
                        (BuildContext context, AsyncSnapshot<Map> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!['title'] != null) {
                          String? currentPriority =
                              snapshot.data!['priority'].toString();
                          String? currentStatus =
                              status[snapshot.data!['status_id'] - 1];
                          String? currentRating = "";
                          snapshot.data!['rating'] == null
                              ? currentRating = 'N/A'
                              : currentRating =
                                  snapshot.data!['rating'].toString();
                          return Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xFF094074),
                                ),
                                width: double.infinity,
                                height: 50,
                                child: Text(
                                  snapshot.data!['title'],
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Text('priority'),
                                            DropdownButton(
                                              // Initial Value
                                              value: currentPriority,

                                              // Down Arrow Icon
                                              icon: const Icon(
                                                  Icons.keyboard_arrow_down),

                                              // Array list of items
                                              items:
                                                  prioritys.map((String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(items),
                                                );
                                              }).toList(),
                                              // After selecting the desired option,it will
                                              // change button value to selected value
                                              onChanged: (String? newValue) {
                                                snapshot.data!['priority'] =
                                                    int.parse(newValue!);
                                                updateTicket(args['id'] ?? '',
                                                    snapshot.data!);
                                                setState(() {
                                                  currentPriority = newValue;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        Text(DateFormat('hh:mm dd-MM-yyyy')
                                            .format(DateTime.parse(
                                                snapshot.data!['created_at']))),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text('status'),
                                        DropdownButton(
                                          // Initial Value
                                          value: currentStatus,

                                          // Down Arrow Icon
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),

                                          // Array list of items
                                          items: status.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items),
                                            );
                                          }).toList(),
                                          // After selecting the desired option,it will
                                          // change button value to selected value
                                          onChanged: (String? newValue) {
                                            snapshot.data!['status_id'] =
                                                status.indexOf(newValue!) + 1;
                                            print(snapshot.data!['status_id']);
                                            updateTicket(args['id'] ?? '',
                                                snapshot.data!);
                                            setState(() {
                                              currentStatus = status[
                                                  snapshot.data!['status_id'] -
                                                      1];
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text('rating'),
                                        DropdownButton(
                                          // Initial Value
                                          value: currentRating,

                                          // Down Arrow Icon
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),

                                          // Array list of items
                                          items: ratings.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items),
                                            );
                                          }).toList(),
                                          // After selecting the desired option,it will
                                          // change button value to selected value
                                          onChanged: (String? newValue) {
                                            if (newValue == 'N/A') {
                                              snapshot.data!['rating'] = null;
                                            } else {
                                              snapshot.data!['rating'] =
                                                  ratings.indexOf(newValue!);
                                            }

                                            // Update the ticket rating
                                            updateTicket(
                                              args['id']!,
                                              snapshot.data!,
                                            );
                                            // Refresh the ticket
                                            setState(() {
                                              currentRating = newValue;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Form(
                                        child: Column(
                                      children: [
                                        TextFormField(
                                          decoration: const InputDecoration(
                                              hintText:
                                                  'Ecrivez votre commentaire'),
                                          controller: myTitle,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Ink(
                                                      decoration:
                                                          const ShapeDecoration(
                                                        color:
                                                            Color(0xFF094074),
                                                        shape: CircleBorder(),
                                                      ),
                                                      child: IconButton(
                                                          icon: const Icon(
                                                            Icons.attach_file,
                                                            color: Colors.white,
                                                          ),
                                                          onPressed: () =>
                                                              _getImage()),
                                                    ),
                                                  ),
                                                  _pickedFile == null
                                                      ? const Text(
                                                          'Aucun fichier sélectionné')
                                                      : const Text(
                                                          'Fichier sélectionné.'),
                                                ],
                                              ),
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          const Color(
                                                              0xFF094074)),
                                                ),
                                                onPressed: () {
                                                  // Validate will return true if the form is valid, or false if
                                                  // the form is invalid.

                                                  if (myTitle.text != '') {
                                                    // If the form is valid, we want to show a Snackbar
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                      content: Text(
                                                          'Commentaire ajouté avec succès'),
                                                      duration:
                                                          Duration(seconds: 1),
                                                    ));
                                                    // Add the comment to the ticket
                                                    createTicketContent(
                                                            args['id'] ?? '',
                                                            myTitle.text)
                                                        .then(((value) =>
                                                            setState(() {
                                                              ticketContents =
                                                                  getTicketContents(
                                                                      args['id'] ??
                                                                          "");
                                                            })));

                                                    // Clear the text field
                                                    myTitle.clear();

                                                    // Refresh the ticket contents

                                                  }
                                                },
                                                child: const Text('Submit'),
                                              ),
                                            ])
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else {
                          return const Center(
                            child: Text('No ticket found'),
                          );
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                    future: ticket),
                FutureBuilder(
                    builder:
                        (BuildContext context, AsyncSnapshot<List> snapshot) {
                      if (snapshot.hasData) {
                        List? contents = snapshot.data?.reversed.toList();
                        return Expanded(
                            child: ListView.builder(
                          itemCount: contents!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Dismissible(
                              key: UniqueKey(),
                              background: Container(
                                color: Colors.red,
                                padding: const EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      "Supprimer",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                              child: ticketContentTile(
                                  contents[index]["text"],
                                  DateFormat('hh:mm dd-MM-yyyy').format(
                                      DateTime.parse(
                                          contents[index]["created_at"])),
                                  contents[index]['first_name'],
                                  contents[index]['avatar'],
                                  context),
                              onDismissed: (direction) {
                                deleteContent(args['id'] ?? '',
                                        contents[index]['id'].toString())
                                    .then((value) =>
                                        contents.remove(contents[index]))
                                    .then((value) {
                                  setState(() {
                                    ticketContents =
                                        getTicketContents(args['id'] ?? '');
                                  });
                                });
                              },
                            );
                          },
                        ));
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                    future: ticketContents),
              ],
            ),
          ));
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
