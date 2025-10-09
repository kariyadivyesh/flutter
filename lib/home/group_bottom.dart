import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitify/home/group.dart'; // ✅ Import Group Screen
import 'package:splitify/home/group_data.dart';

class GroupBottom extends StatefulWidget {
  const GroupBottom({super.key});

  @override
  State<GroupBottom> createState() => _GroupBottomState();
}

class _GroupBottomState extends State<GroupBottom> {
  List<Map<String, dynamic>> groupsList = [];

  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  Future<void> _loadGroups() async {
    final prefs = await SharedPreferences.getInstance();
    final savedGroups = prefs.getString('groupsList');
    if (savedGroups != null) {
      final decoded = jsonDecode(savedGroups) as List;
      setState(() {
        groupsList = decoded.map((e) => Map<String, dynamic>.from(e)).toList();
      });
    } else {
      groupsList = groups; // Default static groups from your group_data.dart
    }
  }

  Future<void> _saveGroups() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('groupsList', jsonEncode(groupsList));
  }

  void _deleteGroup(int index) async {
    setState(() {
      groupsList.removeAt(index);
    });
    await _saveGroups();
  }

  void _openGroupDetail(Map<String, dynamic> group) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Group(
          groupName: group["title"],
          groupId: group["id"] ?? "No ID",
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
        title: const Text("Splitify", style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Groups",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: groupsList.isEmpty
                  ? const Center(child: Text("No groups yet"))
                  : ListView.builder(
                      itemCount: groupsList.length,
                      itemBuilder: (context, index) {
                        final group = groupsList[index];
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 64, 155, 230),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                onTap: () => _openGroupDetail(group),
                                leading: Text(group["icon"] ?? "💬",
                                    style: const TextStyle(fontSize: 24)),
                                title: Text(group["title"] ?? "Unnamed Group",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 20)),
                                subtitle: Text(group["date"] ?? "",
                                    style:
                                        const TextStyle(color: Colors.white70)),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.white),
                                  onPressed: () => _deleteGroup(index),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
