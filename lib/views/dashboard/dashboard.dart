import 'package:flutter/material.dart';
import 'package:laradesk_flutter/views/tickets/tickets.dart';
import '../dashboard/data.dart';
import 'package:laradesk_flutter/views/dashboard/users/Users.dart';

class NavBarDash extends StatefulWidget {
  const NavBarDash({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);
  final int selectedIndex;

  @override
  State<NavBarDash> createState() => _NavBarDashState();
}

class _NavBarDashState extends State<NavBarDash> {
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
              icon: Icon(Icons.data_array),
              label: "Data",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: "Users",
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
        return const DataPage();
      case 1:
        return const UsersList();
      default:
        return const TicketList();
    }
  }
}
