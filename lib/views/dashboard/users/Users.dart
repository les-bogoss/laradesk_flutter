import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controllers/get_all_users.dart';

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  //get all tickets from server

  @override
  void initState() {
    super.initState();
  }

  Future getUsers() async {
    //get all tickets from server
    var users = await getAllUsers();
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users | Dashboard',
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
      body: FutureBuilder(
        future: getAllUsers(),
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
                      '/user',
                      arguments: {'id': snapshot.data[index]['id'].toString()},
                    );
                  },
                  child: ListTile(
                    title: Text(
                        snapshot.data[index]['last_name'].toUpperCase() +
                            ' ' +
                            snapshot.data[index]['first_name']),
                    subtitle: Text(snapshot.data[index]['email']),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      backgroundImage: NetworkImage(
                          "https://34.140.17.43${snapshot.data[index]['avatar']}"),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
