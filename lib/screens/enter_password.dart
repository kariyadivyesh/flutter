import 'package:flutter/material.dart';
import 'package:splitify/screens/new_password.dart';

class EnterPassword extends StatefulWidget {
  const EnterPassword({super.key});

  @override
  State<EnterPassword> createState() => _EnterPasswordState();
}

class _EnterPasswordState extends State<EnterPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 190,
            ),
            Text(
              'Enter OTP',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'we have send a 6 digit',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'verification code to your email.',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                SizedBox(
                  width: 50,
                ),
                Container(
                  height: 40,
                  width: 40,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 40,
                  width: 40,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 40,
                  width: 40,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 40,
                  width: 40,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 40,
                  width: 40,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 40,
                  width: 40,
                  color: Colors.grey,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Resend OTP',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 90,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewPassword()));
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Text(
                  'Verify',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
