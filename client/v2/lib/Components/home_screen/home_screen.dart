import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './steps_counter.dart';
import './distance_covered.dart';
import './calories_screen.dart';
import './blood_oxygen.dart';
import './sleep_duration.dart';
import '../Persnoal_Profile/Dasboard.dart';
import './Heart_rate.dart'; // Correct import

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    Text('Community'), // Placeholder for Sharing screen content
    Text('Achievement'),  // Placeholder for Browse screen content
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Dashboard()), // Navigate to Dashboard
                );
              },
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 20,  // Adjusted radius to fit the AppBar better
                child: SvgPicture.asset(
                  'assets/vectors/Profile_Pic.svg',
                  width: 40,  // Adjusted width and height to fit within the CircleAvatar
                  height: 40,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Good Afternoon 🌤️',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            const Spacer(),
            SvgPicture.asset(
              'assets/vectors/logo.svg', 
              width: 40,
              height: 40,
            ),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex), // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Summary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Communities',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove_red_eye),
            label: 'Achievement',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StepsCounterScreen()),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.directions_walk, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Steps Counter',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                  Text(
                    '6000/10000',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          DashboardTile(
            iconPath: 'assets/vectors/distance.svg', 
            title: 'Distance Covered',
            subtitle: '1.9 km • Last update 3min',
            navigationScreen: DistanceCoveredScreen(), // Navigate to DistanceCoveredScreen
          ),
          DashboardTile(
            iconPath: 'assets/vectors/calories.svg', 
            title: 'Calories',
            subtitle: '0/400 kcal • Last update 3d',
            navigationScreen: CaloriesScreen(), // Navigate to CaloriesScreen
          ),
          DashboardTile(
            iconPath: 'assets/vectors/Blood_Oxygen.svg', 
            title: 'Blood Oxygen',
            subtitle: '95% • Last update 3min',
            navigationScreen: BloodOxygenScreen(), // Navigate to BloodOxygenScreen
          ),
          DashboardTile(
            iconPath: 'assets/vectors/Heart_Rate.svg', 
            title: 'Heart Rate',
            subtitle: '96% • Last update 3min',
            navigationScreen: HeartRateScreen(), // Correct usage
          ),
          const SizedBox(height: 16),
          const Text(
            'Sleep',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          DashboardTile(
            iconPath: 'assets/vectors/moon-zzz.svg', 
            title: 'Sleep Duration',
            subtitle: 'No Data • Last update 1min',
            navigationScreen: SleepDurationScreen(), // Navigate to SleepDurationScreen
          ),
        ],
      ),
    );
  }
}

class DashboardTile extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final Widget navigationScreen;

  const DashboardTile({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.navigationScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => navigationScreen),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                iconPath,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}
