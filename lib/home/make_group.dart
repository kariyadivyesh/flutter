import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitify/home/group.dart'; // Make sure this import path matches your project

class MakeGroup extends StatefulWidget {
  const MakeGroup({super.key});

  @override
  State<MakeGroup> createState() => _MakeGroupState();
}

class _MakeGroupState extends State<MakeGroup> {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController groupIdController = TextEditingController();

  Future<void> _createGroup() async {
    final groupName = groupNameController.text.trim();
    final groupId = groupIdController.text.trim();

    if (groupName.isEmpty || groupId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter both fields")),
      );
      return;
    }

    // Load existing groups from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final savedGroups = prefs.getString('groupsList');
    List<Map<String, dynamic>> groupsList = [];

    if (savedGroups != null) {
      final decoded = jsonDecode(savedGroups) as List;
      groupsList = decoded.map((e) => Map<String, dynamic>.from(e)).toList();
    }

    // Create a new group
    final newGroup = {
      "title": groupName,
      "id": groupId,
      "icon": "💬",
      "date": DateTime.now().toString().substring(0, 10),
    };

    // Add new group and save back
    groupsList.add(newGroup);
    await prefs.setString('groupsList', jsonEncode(groupsList));

    // Navigate directly to the new group screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Group(
          groupName: groupName,
          groupId: groupId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Create Group",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter Group Name",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: groupNameController,
              decoration: InputDecoration(
                hintText: "Enter group name",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Enter Group ID",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: groupIdController,
              decoration: InputDecoration(
                hintText: "Enter group ID",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: _createGroup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 95, 87, 241),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Create Group",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
