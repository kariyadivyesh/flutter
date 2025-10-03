import 'package:flutter/material.dart';
import 'package:splitify/home/group.dart';

class JoinGroupScreen extends StatelessWidget {
  const JoinGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // matches your design
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Join Group',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, // centers vertically
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Enter Group Code
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter Group Code",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
              ),
              const SizedBox(height: 30),

              // Join Group Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF5B5BFF), // matches your purple button
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Group(groupName: "shopping", groupId: "sho123")));
                },
                child: const Text(
                  "Join Group",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 0, // Groups tab active
      //   selectedItemColor: const Color(0xFF5B5BFF),
      //   unselectedItemColor: Colors.grey,
      //   type: BottomNavigationBarType.fixed,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
      //     BottomNavigationBarItem(icon: Icon(Icons.group), label: ""),
      //     BottomNavigationBarItem(icon: Icon(Icons.history), label: ""),
      //     BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ""),
      //     BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
      //   ],
      // ),
    );
  }
}
