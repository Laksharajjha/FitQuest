import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:v2/Models/user_model.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late Future<User> _user;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // final String email = ModalRoute.of(context)!.settings.arguments as String;
    _user = fetchUser();
  }

  Future<User> fetchUser() async {
    final url = Uri.parse(
        'http://localhost:3000/v1/api/user/get-user?email=raja@gmail.com');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        setState(() {
          _errorMessage = 'Failed to load user data: ${response.statusCode}';
        });
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
      throw e;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _errorMessage != null
                ? Center(child: Text(_errorMessage!))
                : FutureBuilder<User>(
                    future: _user,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        final user = snapshot.data!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.directions_walk,
                                          color: Colors.white),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'Steps Counter',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    '6000/10000',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            DashboardTile(
                              iconPath: 'assets/vectors/distance.svg',
                              title: 'Distance Covered',
                              subtitle: '1.9 km • Last update 3min',
                            ),
                            DashboardTile(
                              iconPath: 'assets/vectors/calories.svg',
                              title: 'Calories',
                              subtitle: '0/400 kcal • Last update 3d',
                            ),
                            DashboardTile(
                              iconPath: 'assets/vectors/water.svg',
                              title: 'Blood Oxygen',
                              subtitle: '95% • Last update 3min',
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Sleep',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            DashboardTile(
                              iconPath: 'assets/vectors/sleep.svg',
                              title: 'Sleep duration',
                              subtitle: 'No Data • Last update 1min',
                            ),
                          ],
                        );
                      } else {
                        return Center(child: Text('No data available'));
                      }
                    },
                  ),
      ),
    );
  }
}

class DashboardTile extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;

  const DashboardTile({
    Key? key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
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
              width: 40,
              height: 40,
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
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
