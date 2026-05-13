import 'package:flutter/material.dart';
import 'screens/homepage.dart';
import 'screens/register.dart';
import 'screens/login.dart';
import 'screens/concert.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Giggo',
      initialRoute: '/',
      routes: {
        '/': (context) => const Homepage(),
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/concert': (context) => const ConcertDetailsPage(),
      },
    );
  }
}
