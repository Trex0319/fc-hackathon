import 'package:flutter/material.dart';
import 'package:hackathon/screen/home_screen.dart';
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
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 225, 252, 168)),
        useMaterial3: true,
      ),
      home: const LoginScreen(), // Set the LoginScreen as the start screen
      routes: {
        '/profile': (context) => const UserScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    // Hard-coded user data
    if (_emailController.text == "user@example.com" &&
        _passwordController.text == "password") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const HomeScreen(title: 'Worker Ranking')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
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

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final List<User> _users = [
//     User("Alice", 24, 85000),
//     User("Bob", 28, 92000),
//     User("Charlie", 22, 78000),
//     User("David", 30, 95000),
//     User("Eve", 26, 91000),
//     User("Frank", 31, 100000),
//     User("Grace", 27, 97000),
//     User("Heidi", 25, 86000),
//     User("Ivan", 29, 93000),
//     User("Judy", 23, 88000),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     // Sort users based on earnings in descending order
//     _users.sort((a, b) => b.earnings.compareTo(a.earnings));
//   }

//   void _goToUserProfile() {
//     Navigator.pushNamed(context, '/profile');
//   }

//   void _logout() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: _logout, // Logout button in AppBar
//             tooltip: 'Logout',
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: _users.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text('${index + 1}. ${_users[index].name}'),
//             subtitle: Text('Age: ${_users[index].age}, Earnings: \$${_users[index].earnings}'),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _goToUserProfile,
//         tooltip: 'Go to Profile',
//         child: const Icon(Icons.person),
//       ),
//     );
//   }
// }