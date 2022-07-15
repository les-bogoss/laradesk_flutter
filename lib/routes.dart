import 'views/home/home.dart';
import 'views/home/login.dart';
import 'views/home/register.dart';

var appRoutes = {
  '/': (context) => const HomePage(),
  '/login': (context) => const LoginPage(),
  '/register': (context) => const RegisterPage(),
};
