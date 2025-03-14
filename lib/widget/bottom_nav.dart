import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final VoidCallback onLogout; // Added a callback for logout

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.onLogout, // Add the logout function to the constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize:
          MainAxisSize.min, // Ensure the column takes only necessary space
      children: [
        // Bottom Navigation Bar
        BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            if (index == 4) {
              onLogout(); 
            } else {
              onTap(index); 
            }
          },
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard),
              label: 'Leaderboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_document),
              label: 'Report',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_fire_department),
              label: 'Streak',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout),
              label: 'Logout',
            ),
          ],
        ),
      ],
    );
  }
}
