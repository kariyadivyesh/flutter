import 'package:flutter/material.dart';
import 'package:splitify/screens/enter_password.dart';
import 'package:splitify/screens/login_screen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
            ),
            Text(
              'Forgot Password',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Enter Your Register Email',
                    prefixIcon: Icon(Icons.email)),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EnterPassword()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: Text(
                'Send OTP',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 190,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text('Back To Login'))
          ],
        ),
      ),
    );
  }
}
