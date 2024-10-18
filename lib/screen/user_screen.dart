import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Hardcoded user details
    const String userName = "Denish Rao";
    const int userAge = 22;
    const double userEarnings = 85000;
    const String userEmail = "alice.johnson@example.com";
    const String userPosition = "Head of Farmer";
    const String profilePictureUrl =
        'https://e7.pngegg.com/pngimages/527/663/png-clipart-logo-person-user-person-icon-rectangle-photography-thumbnail.png';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile picture
            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(profilePictureUrl),
            ),
            const SizedBox(height: 20),
            // User name
            Text(
              userName,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            // Position
            Text(
              userPosition,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            // Age and salary details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text(
                      'Age',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '$userAge years',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Earnings',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '\$$userEarnings',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Today's performance: 7 tonnes"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Ranking: 3'),
                    SizedBox(width: 8),
                    Icon(
                      Icons.local_fire_department,
                      color: Colors.orange,
                      size: 20,
                    ),
                    Text(
                      'Bonus: RM20',
                      style:
                          TextStyle(fontWeight: FontWeight.w200, fontSize: 10),
                    ),
                  ],
                ),
                Text(
                  'Goal progress: 75%',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                LinearProgressIndicator(
                  value: 0.75, // Represents 75% progress
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                  minHeight: 5,
                ),
                SizedBox(height: 10),
                Text(
                  'You are almost there!',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Divider(),
            // Additional user details (e.g., email)
            const ListTile(
              leading: Icon(Icons.email),
              title: Text(userEmail),
              subtitle: Text('Email Address'),
            ),
            const ListTile(
              leading: Icon(Icons.phone),
              title: Text('+1 234 567 890'),
              subtitle: Text('Phone Number'),
            ),
            const ListTile(
              leading: Icon(Icons.location_city),
              title: Text('1234 Main St, Springfield'),
              subtitle: Text('Address'),
            ),
          ],
        ),
      ),
    );
  }
}
