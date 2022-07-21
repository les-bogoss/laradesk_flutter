import 'package:laradesk_flutter/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:laradesk_flutter/views/tickets/tickets.dart';
import 'package:laradesk_flutter/views/utils/navbar.dart';
import 'views/home/login.dart';
import 'views/home/register.dart';
import 'views/tickets/ticket.dart';

var appRoutes = {
  '/': (context) => const NavBar(
        selectedIndex: 0,
      ),
  '/unlogged': (context) => const HomePage(),
  '/login': (context) => const LoginPage(),
  '/register': (context) => const RegisterPage(),
  '/tickets': (context) => const TicketList(),
  '/ticket': (context) => const TicketPage(),
};
