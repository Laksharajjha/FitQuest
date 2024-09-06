import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2/Components/Fourm_Screen/forum_screen.dart';
import './steps_counter.dart';
import './distance_covered.dart';
import './calories_screen.dart';
import './sleep_duration.dart';
import '../Persnoal_Profile/Dasboard.dart';
import './Heart_rate.dart';
import '../Achivements/achieve_ments.dart';

class HomeScreen extends StatefulWidget {
  final String email;

  HomeScreen({super.key, required this.email});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    Container(),
    const CommentListScreen(),
    AchieveMents(),
  ];

  Future<Map<String, dynamic>> fetchUser(String email) async {
    try {
      var dio = Dio();
      final response = await dio.put(
        'http://localhost:3000/v1/api/health/user-data/$email',
      );
      if (response.statusCode == 200) {
        return response.data["data"];
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      throw Exception("Error Fetching User Data: $e");
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Dashboard(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 20,
                      child: SvgPicture.asset(
                        'assets/vectors/Profile_Pic.svg',
                        width: 40,
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
            )
          : null,
      body: _selectedIndex == 0
          ? FutureBuilder<Map<String, dynamic>>(
              future: fetchUser(widget.email),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No data found'));
                } else {
                  return HomeContent(userData: snapshot.data);
                }
              },
            )
          : _widgetOptions.elementAt(_selectedIndex),
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
            icon: Icon(Icons.emoji_events),
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
  final Map<String, dynamic>? userData;

  const HomeContent({super.key, this.userData});

  @override
  Widget build(BuildContext context) {
    print("print inside Home");
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardTile(
              icon: Icons.directions_walk,
              title: 'Steps Counter',
              subtitle:
                  ('${userData?["step"]?.toString() ?? 'Loading...'} / 1000'),
              navigationScreen: StepsCounterScreen(),
              iconColor: Colors.blue,
            ),
            const SizedBox(height: 16),
            DashboardTile(
              iconPath: 'assets/vectors/distance.svg',
              title: 'Distance Covered',
              subtitle: userData?["distance"]?.toString() ?? 'Loading...',
              navigationScreen: DistanceCoveredScreen(),
            ),
            DashboardTile(
              iconPath: 'assets/vectors/calories.svg',
              title: 'Calories',
              subtitle:
                  '${userData?["calories"]?.toString() ?? 'Loading...'} / 2000',
              navigationScreen: CaloriesScreen(),
            ),
            DashboardTile(
              iconPath: 'assets/vectors/Heart_Rate.svg',
              title: 'Heart Rate',
              subtitle: userData?["heartRate"]?.toString() ?? 'Loading...',
              navigationScreen: HeartRateScreen(),
            ),
            const SizedBox(height: 16),
            const Text(
              'Sleep',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            DashboardTile(
              iconPath: 'assets/vectors/moon-zzz.svg',
              title: 'Sleep Duration',
              subtitle: userData?["sleep"]?.toString() ?? 'Loading...',
              navigationScreen: SleepDurationScreen(),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardTile extends StatelessWidget {
  final IconData? icon;
  final String? iconPath;
  final String title;
  final String subtitle;
  final Widget navigationScreen;
  final Color? iconColor;

  const DashboardTile({
    super.key,
    this.icon,
    this.iconPath,
    required this.title,
    required this.subtitle,
    required this.navigationScreen,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => navigationScreen),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            if (icon != null)
              Icon(icon, color: iconColor ?? Colors.black, size: 24),
            if (iconPath != null)
              SvgPicture.asset(iconPath!, width: 24, height: 24),
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
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
