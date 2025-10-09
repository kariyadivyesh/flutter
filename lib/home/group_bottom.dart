// lib/home/group_bottom.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'group_data.dart';
import 'group.dart';

class GroupBottom extends StatefulWidget {
  const GroupBottom({Key? key}) : super(key: key);

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
    try {
      final loadedGroups = await loadGroupsFromPrefs(); // dynamic groups
      setState(() {
        groupsList = loadedGroups;
      });
    } catch (e) {
      setState(() {
        groupsList = [];
      });
    }
  }

  Future<void> _deleteGroup(int index) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      groupsList.removeAt(index); // remove from local list
    });
    await prefs.setString(
        'groupsList', jsonEncode(groupsList)); // save updated list
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Group deleted successfully")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✅ White background
      appBar: AppBar(
        title: const Text("Groups"),
        backgroundColor: Colors.white, // white AppBar
        elevation: 0,
        foregroundColor: Colors.black, // black text/icons
      ),
      body: groupsList.isEmpty
          ? const Center(child: Text("No groups found"))
          : ListView.builder(
              itemCount: groupsList.length,
              itemBuilder: (context, index) {
                final g = groupsList[index];
                return Card(
                  color: Colors.white, // ✅ Card background white
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                  child: ListTile(
                    leading: Text(
                      g['icon'] ?? '💬',
                      style: const TextStyle(fontSize: 24),
                    ),
                    title: Text(
                      g['title'] ?? 'Unnamed Group',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Text("Created on ${g['date'] ?? ''}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteGroup(index),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 18),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Group(
                            groupName: g['title'] ?? 'Unnamed Group',
                            groupId: g['id'] ?? '',
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
