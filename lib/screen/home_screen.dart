import 'package:flutter/material.dart';
import 'package:hackathon/main.dart';
import 'package:hackathon/screen/login_screen.dart';
import 'package:hackathon/screen/user_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<User> _users = [
    User("Alice", 24, 85000),
    User("Bob", 28, 92000),
    User("Charlie", 22, 78000),
    User("David", 30, 95000),
    User("Eve", 26, 91000),
    User("Frank", 31, 100000),
    User("Grace", 27, 97000),
    User("Heidi", 25, 86000),
    User("Ivan", 29, 93000),
    User("Judy", 23, 88000),
    User("Denish", 22, 1000),
    User("Alvin", 26, 2000)
  ];

  @override
  void initState() {
    super.initState();
    // Sort users based on earnings in descending order
    _users.sort((a, b) => b.earnings.compareTo(a.earnings));
  }

  void _goToUserProfile(User user) {
    // Navigate to the UserDetailScreen and pass the selected user
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetailScreen(user: user),
      ),
    );
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout, // Logout button in AppBar
            tooltip: 'Logout',
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          // Define different styles for the top 3 and others
          bool isTop3 = index < 3;
          TextStyle textStyle = isTop3
              ? const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)
              : const TextStyle(fontSize: 16, fontWeight: FontWeight.normal);

          return ListTile(
            title: Text(
              '${index + 1}. ${_users[index].name}',
              style: textStyle, // Apply style to the name
            ),
            subtitle: Text(
              'Age: ${_users[index].age}, Earnings: \$${_users[index].earnings}',
              style: textStyle, // Apply style to the earnings and age
            ),
            onTap: () => _goToUserProfile(_users[index]), // Navigate on tap
          );
        },
      ),
    );
  }
}
