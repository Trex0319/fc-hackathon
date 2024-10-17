import 'package:flutter/material.dart';
import 'package:hackathon/screen/login_screen.dart';
import 'package:hackathon/screen/user_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hackathon',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 225, 252, 168)),
        useMaterial3: true,
      ),
      home: const LoginScreen(), // Set the LoginScreen as the start screen
      routes: {
        '/profile': (context) => const UserScreen(),
      },
    );
  }
}


// Updated User class to include earnings
class User {
  final String name;
  final int age;
  final double earnings;

  User(this.name, this.age, this.earnings);
}