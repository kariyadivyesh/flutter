import 'package:flutter/material.dart';
import 'package:splitify/home/group.dart';
import 'package:splitify/home/group_data.dart';

class MakeGroup extends StatelessWidget {
  MakeGroup({super.key});

  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController groupIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Create Group",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Group Name Input
            TextField(
              controller: groupNameController,
              decoration: InputDecoration(
                hintText: "Enter Group Name",
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Group ID Input
            TextField(
              controller: groupIdController,
              decoration: InputDecoration(
                hintText: "Enter Group ID",
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Create Button
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  final name = groupNameController.text.trim();
                  final id = groupIdController.text.trim();

                  if (name.isEmpty || id.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fill all fields")),
                    );
                    return;
                  }

                  // Create new group dynamically
                  final newGroup = <String, dynamic>{
                    "icon": "👥",
                    "title": name,
                    "date": DateTime.now().toString().substring(0, 10),
                    "expenses": <Map<String, dynamic>>[],
                  };

                  // Add to your global list
                  groups.add(newGroup);

                  // Navigate to Group screen dynamically
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Group(
                        groupName: name,
                        groupId: id,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Create",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
