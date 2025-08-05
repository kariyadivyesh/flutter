import 'package:flutter/material.dart';
import 'package:splitify/screens/forgot_password.dart';
import 'package:splitify/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                'Login To Splitify',
                style: TextStyle(fontSize: 40),
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
                      labelText: 'Enter Your Password',
                      labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                      prefixIcon: Icon(Icons.lock)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPassword()));
                      },
                      child: Text('Forgot Password?'))
                ],
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
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  )),
              SizedBox(
                height: 20,
              ),
              Text(
                '----------OR----------',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
