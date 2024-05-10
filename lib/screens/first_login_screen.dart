import 'package:education_app/screens/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _userIdController = TextEditingController();
  String _password = '';

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Login',
              style: TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 16.0),
            Container(
              width: 200.0,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                controller: _userIdController,
                decoration: const InputDecoration(
                  hintText: 'User ID',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              width: 200.0,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Password',
                  border: InputBorder.none,
                ),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Add your login logic here
                if (kDebugMode) {
                  print('User ID: ${_userIdController.text}');
                }
                if (kDebugMode) {
                  print('Password: $_password');
                }

                // Navigate to another page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UsersListScreen()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}