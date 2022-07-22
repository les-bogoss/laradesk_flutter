import 'package:laradesk_flutter/views/home/home.dart';
import 'package:laradesk_flutter/views/tickets/tickets.dart';
import 'package:laradesk_flutter/views/utils/navbar.dart';
import 'views/home/login.dart';
import 'views/home/register.dart';
import 'views/tickets/ticket.dart';
import 'views/dashboard/data.dart';
import 'views/dashboard/dashboard.dart';
import 'views/dashboard/users/users.dart';
import 'views/dashboard/users/user.dart';

var appRoutes = {
  '/home': (context) => const NavBar(
        selectedIndex: 0,
      ),
  '/unlogged': (context) => const HomePage(),
  '/login': (context) => const LoginPage(),
  '/register': (context) => const RegisterPage(),
  '/tickets': (context) => const TicketList(),
  '/ticket': (context) => const TicketPage(),
  '/users': (context) => const UsersList(),
  '/user': (context) => const UserPage(),
  '/dashboard': (context) => const NavBarDash(
        selectedIndex: 0,
      ),
};
