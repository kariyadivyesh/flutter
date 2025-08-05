import 'package:flutter/material.dart';

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
        ],
      ),
    );
  }
}
