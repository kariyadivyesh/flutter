import 'package:flutter/material.dart';
import 'package:splitify/home/group_data.dart';

class GroupBottom extends StatefulWidget {
  const GroupBottom({super.key});

  @override
  State<GroupBottom> createState() => _GroupBottomState();
}

class _GroupBottomState extends State<GroupBottom> {
  void _deleteGroup(int index) {
    setState(() {
      groups.removeAt(index);
    });
  }

  void _openGroupDetail(Map<String, dynamic> group) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GroupDetailScreen(group: group)),
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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.person, color: Colors.black),
          ),
        ],
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
              child: ListView.builder(
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  final group = groups[index];
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 64, 155, 230),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          onTap: () => _openGroupDetail(group),
                          leading: Text(group["icon"]?.toString() ?? "",
                              style: const TextStyle(fontSize: 24)),
                          title: Text(group["title"]?.toString() ?? "",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 20)),
                          subtitle: Text(group["date"]?.toString() ?? "",
                              style: const TextStyle(color: Colors.white70)),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.white),
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

class GroupDetailScreen extends StatelessWidget {
  final Map<String, dynamic> group;

  const GroupDetailScreen({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    // Removed expenses to avoid casting issues
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(group["title"]?.toString() ?? ""),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "${group["icon"]?.toString() ?? ""} ${group["title"]?.toString() ?? ""}",
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Created on ${group["date"]?.toString() ?? ""}"),
            const SizedBox(height: 20),
            const Center(child: Text("Expenses feature removed")),
          ],
        ),
      ),
    );
  }
}
