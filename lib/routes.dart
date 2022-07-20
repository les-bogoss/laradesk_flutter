import 'package:laradesk_flutter/views/tickets/tickets.dart';

import 'views/home/home.dart';
import 'views/home/login.dart';
import 'views/home/register.dart';
import 'views/dashboard/data.dart';

var appRoutes = {
  '/': (context) => const HomePage(),
  '/login': (context) => const LoginPage(),
  '/register': (context) => const ItemsWidget(),
  '/tickets': (context) => const TicketList(),
  '/dashboard': (context) => const DataPage(),
};
