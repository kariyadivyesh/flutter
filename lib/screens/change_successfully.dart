import 'package:flutter/material.dart';
import 'package:splitify/screens/login_screen.dart';

class ChangeSuccessfully extends StatefulWidget {
  const ChangeSuccessfully({super.key});

  @override
  State<ChangeSuccessfully> createState() => _ChangeSuccessfullyState();
}

class _ChangeSuccessfullyState extends State<ChangeSuccessfully> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 190,
          ),
          Center(
            child: Text(
              "Password Changed \n       Successfully",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
              height: 150,
              width: 100,
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 40,
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Text(
            'Your Password Has Been Changed',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 80,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text(
                "Go To Login",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
