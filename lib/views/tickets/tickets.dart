import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/create_ticket.dart';
import '../../controllers/get_all_tickets.dart';

class TicketList extends StatefulWidget {
  const TicketList({Key? key}) : super(key: key);

  @override
  State<TicketList> createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> {
  //get all tickets from server

  @override
  void initState() {
    super.initState();
  }

  Future getTickets() async {
    //get all tickets from server
    var tickets = await getAllTickets();
    return tickets;
  }

  Future<void> refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tickets',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF094074),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createTicketDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      //list view all tickets
      body: RefreshIndicator(
        onRefresh: refresh,
        child: FutureBuilder(
          future: getTickets(),
          initialData: const [],
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      //go to ticket detail
                      Navigator.pushNamed(
                        context,
                        '/ticket',
                        arguments: {
                          'id': snapshot.data[index]['id'].toString()
                        },
                      );
                    },
                    child: ListTile(
                      title: Text(snapshot.data[index]['title']),
                      subtitle:
                          Text(snapshot.data[index]['updated_at'].toString()),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        backgroundImage: NetworkImage(
                            "https://34.140.17.43${snapshot.data[index]['avatar']}"),
                      ),
                      trailing: snapshot.data[index]['priority'] == 3
                          ? const Icon(
                              Icons.error,
                              color: Colors.red,
                            )
                          : snapshot.data[index]['priority'] == 2
                              ? const Icon(
                                  Icons.error,
                                  color: Colors.yellow,
                                )
                              : const Icon(
                                  Icons.error,
                                  color: Colors.green,
                                ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  createTicketDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          String? currentPriority = '1';
          final myTitle = TextEditingController();
          return AlertDialog(
            title: const Text('Create Ticket'),
            content: SizedBox(
              height: 200,
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: myTitle,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                  ),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter dropDownState) {
                      return DropdownButton<String>(
                        value: currentPriority,
                        items: <String>['1', '2', '3'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          currentPriority = value;
                          dropDownState((() => {}));
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text('Create'),
                onPressed: () {
                  //create ticket

                  if (myTitle.text != '') {
                    var response = createTicket(myTitle.text, currentPriority!);
                    response.then((value) {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        '/ticket',
                        arguments: {'id': value['id'].toString()},
                      );
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Please fill all fields'),
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
              ),
            ],
          );
        });
  }
}
