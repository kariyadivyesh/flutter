import 'package:flutter/material.dart';
import 'package:splitify/screens/change_successfully.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 280,
              ),
              Text(
                "Create New Password",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Enter Your New Password Below",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "New Password", prefixIcon: Icon(Icons.lock)),
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "Confirm Password",
                    prefixIcon: Icon(Icons.lock)),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeSuccessfully()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
