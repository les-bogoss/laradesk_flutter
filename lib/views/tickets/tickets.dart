import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
}
