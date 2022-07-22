import 'package:flutter/material.dart';
import 'package:laradesk_flutter/views/tickets/tickets.dart';
import 'package:laradesk_flutter/views/utils/settings.dart';

import 'NavDashboard.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);
  final int selectedIndex;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.featured_play_list_outlined),
              label: "Tickets",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFFFFDD4A),
          unselectedItemColor: Colors.white,
          backgroundColor: const Color(0xFF094074),
          elevation: 0,
          onTap: (int index) async {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: _buildPage(_selectedIndex),
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const TicketList();
      case 1:
        return const NavBarDash(
          selectedIndex: 0,
        );
      case 2:
        return const Settings();
      default:
        return const TicketList();
    }
  }
}
