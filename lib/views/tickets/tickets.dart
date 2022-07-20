import 'package:flutter/material.dart';
import 'package:laradesk_flutter/models/preferences.dart';

class TicketList extends StatelessWidget {
  const TicketList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          ElevatedButton(
            child: const Text(
              'logout',
            ),
            onPressed: () {
              Preferences2.setLoggedIn(context, false, null);
            },
          ),
        ],
      ),
    );
  }
}
