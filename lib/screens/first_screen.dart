import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'first_login_screen.dart';

class FirstLogin extends StatelessWidget {
  const FirstLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/program_photo.jpg',
              width: 200.0,
              height: 200.0,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    side: MaterialStateProperty.all<BorderSide>(const BorderSide(color: Colors.black)),
                  ),
                  child: const Text('Login'),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Add your register logic here
                    if (kDebugMode) {
                      print('Register button pressed');
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: const Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
