import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/main.dart';
class UserDetailScreen extends StatelessWidget {
  final User user;
  const UserDetailScreen({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${user.name}'s Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/ic.png'), // Change to actual image path
            ),
            const SizedBox(height: 20),
            Text(
              'Name: ${user.name}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Age: ${user.age}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Earnings: \$${user.earnings}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            Text(
              'Position: Software Engineer', // Hardcoded, but you can expand the User class
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Email: ${user.name.toLowerCase().replaceAll(" ", ".")}@example.com', // Mock email
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            const Text(
              'Earnings Overview', // Title for the chart
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          TextStyle style = const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          );
                          String text;
                          switch (value.toInt()) {
                            case 0:
                              text = 'Mon';
                              break;
                            case 1:
                              text = 'Tue';
                              break;
                            case 2:
                              text = 'Wed';
                              break;
                            case 3:
                              text = 'Thu';
                              break;
                            case 4:
                              text = 'Fri';
                              break;
                            case 5:
                              text = 'Sat';
                              break;
                            case 6:
                              text = 'Sun';
                              break;
                            default:
                              text = '';
                          }
                          return Text(text, style: style);
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [BarChartRodData(toY: 50, color: Colors.blue)],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [BarChartRodData(toY: 80, color: Colors.yellow)],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [BarChartRodData(toY: 70, color: Colors.purple)],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [BarChartRodData(toY: 90, color: Colors.green)],
                    ),
                    BarChartGroupData(
                      x: 4,
                      barRods: [BarChartRodData(toY: 30, color: Colors.orange)],
                    ),
                    BarChartGroupData(
                      x: 5,
                      barRods: [BarChartRodData(toY: 100, color: Colors.red)],
                    ),
                    BarChartGroupData(
                      x: 6,
                      barRods: [BarChartRodData(toY: 40, color: Colors.pink)],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}