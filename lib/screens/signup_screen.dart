import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image(
                      image: AssetImage('assets/images/splitify_logo.jpeg')),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Splitify',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Create Your Splitify Account',
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Enter Your Email',
                      labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                      prefixIcon: Icon(Icons.email)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Create Your Password',
                      labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                      prefixIcon: Icon(Icons.lock)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  )),
              SizedBox(
                height: 20,
              ),
              Text(
                'Allready Have An Account? Log In',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
