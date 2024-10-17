import 'package:flutter/material.dart';
import 'package:hackathon/screen/user_detail_screen.dart';
import 'package:hackathon/widget/bottom_nav.dart';
import 'package:hackathon/screen/user_screen.dart';
import 'streak_screen.dart';
import 'package:hackathon/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<User> _users = [
    User("John Doe", 10, 1000),
    User("Jane Doe", 20, 900),
    User("You", 30, 700),
    User("Janice Doe", 40, 500),
    User("James Doe", 50, 500),
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _users.sort((a, b) => b.earnings.compareTo(a.earnings));
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
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
    Navigator.of(context).pushReplacementNamed('/login');
    print('User logged out');
  }

  Widget _buildCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return _buildLeaderboard();
      case 1:
        return const UserScreen();
      case 2:
        return StreakScreen();
      case 3:
        _logout();
        return const SizedBox();
      default:
        return _buildLeaderboard();
    }
  }

  Widget _buildLeaderboard() {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          "Leaderboard",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: _users.length,
            itemBuilder: (context, index) {
              final user = _users[index];
              return ListTile(
                leading: Icon(
                  index == 0
                      ? Icons.emoji_events
                      : index == 1
                          ? Icons.emoji_events_outlined
                          : index == 2
                              ? Icons.emoji_events_rounded
                              : Icons.person,
                  color: index == 0
                      ? Colors.orange
                      : index == 1
                          ? Colors.grey
                          : index == 2
                              ? Colors.brown
                              : Colors.black,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: index < 3 ? Colors.orange : Colors.black,
                      ),
                    ),
                    Text(
                      'Age ${user.age}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                trailing: index == 2
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.arrow_upward, color: Colors.black),
                          const SizedBox(width: 5),
                          Text('${user.earnings}',
                              style: const TextStyle(fontSize: 18)),
                        ],
                      )
                    : Text(
                        '${user.earnings}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      onTap: () => _goToUserProfile(_users[index]), // Navigate on tap
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildCurrentScreen(),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavItemTapped,
        onLogout: _logout, // Pass the logout function to the BottomNavBar
      ),
    );
  }
}
