import 'package:laradesk_flutter/views/home/home.dart';
import 'package:laradesk_flutter/views/tickets/tickets.dart';

import 'views/home/login.dart';
import 'views/home/register.dart';

var appRoutes = {
  '/': (context) => const HomePage(),
  '/login': (context) => const LoginPage(),
  '/register': (context) => const RegisterPage(),
  '/tickets': (context) => const TicketList(),
};