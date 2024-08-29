import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> authenticateUser(String email, String password) async {
    final url = Uri.parse('http://localhost:3000/v1/api/auth/auth?type=login');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print('Authentication successful: ${response.body}');
        Navigator.pushNamed(context, '/welcome', arguments: email);
      } else {
        setState(() {
          if (response.statusCode == 500) {
            _errorMessage = 'Internal server error. Please try again later.';
          } else if (response.statusCode == 401) {
            _errorMessage =
                'Invalid credentials. Please check your email and password.';
          } else {
            _errorMessage = 'Failed to authenticate: ${response.statusCode}';
          }
        });
        print('Failed to authenticate: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 100), // Placeholder for the logo
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                errorText:
                    _errorMessage != null ? 'Invalid email or password' : null,
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                errorText:
                    _errorMessage != null ? 'Invalid email or password' : null,
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      authenticateUser(
                        _emailController.text,
                        _passwordController.text,
                      );
                    },
                    child: Text("Login"),
                  ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
