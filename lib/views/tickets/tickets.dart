import 'package:flutter/material.dart';

import '../../main.dart';

class TicketList extends StatelessWidget {
  const TicketList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Spacer(),
          ElevatedButton(
            child: const Text(
              'salut',
            ),
            onPressed: () async {
              await storage.deleteAll();
              print(await storage.readAll());
            },
          ),
        ],
      ),
    );
  }
}
