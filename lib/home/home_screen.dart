import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitify/home/create_group_screen.dart';
import 'package:splitify/settings/profile_screen.dart';
import 'package:splitify/home/group.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> recentGroups = [];
  List<Map<String, dynamic>> recentExpenses = [];

  @override
  void initState() {
    super.initState();
    _loadGroups();
    _loadExpenses();
  }

  Future<void> _loadGroups() async {
    final prefs = await SharedPreferences.getInstance();
    final savedGroups = prefs.getString('groupsList');
    if (savedGroups != null) {
      final decoded = jsonDecode(savedGroups) as List;
      setState(() {
        recentGroups =
            decoded.map((e) => Map<String, dynamic>.from(e)).toList();
      });
    } else {
      // default groups
      recentGroups = [
        {"title": "Goa Trip", "icon": "🏖️", "date": "4 days ago"},
        {"title": "Movie", "icon": "🎬", "date": "1 week ago"},
        {"title": "Shopping", "icon": "🛍️", "date": "2 weeks ago"},
        {"title": "Office", "icon": "💼", "date": "1 month ago"},
      ];
    }
  }

  Future<void> _loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final savedExpenses = prefs.getString('recentExpenses');
    if (savedExpenses != null) {
      final decoded = jsonDecode(savedExpenses) as List;
      setState(() {
        recentExpenses =
            decoded.map((e) => Map<String, dynamic>.from(e)).toList();
      });
    } else {
      recentExpenses = [
        {
          "title": "Lunch",
          "amount": 500,
          "subtitle": "Today ~ Neha Paid",
          "icon": Icons.restaurant.codePoint
        },
        {
          "title": "Taxi",
          "amount": 300,
          "subtitle": "2 days ago ~ You Paid",
          "icon": Icons.local_taxi.codePoint
        },
        {
          "title": "Snacks",
          "amount": 150,
          "subtitle": "4 days ago ~ Amit Paid",
          "icon": Icons.fastfood.codePoint
        },
      ];
    }
  }

  Future<void> _saveExpenses(List<Map<String, dynamic>> expenses) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('recentExpenses', jsonEncode(expenses));
  }

  void _openGroup(Map<String, dynamic> group) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            Group(groupName: group['title'], groupId: group['id'] ?? '000'),
      ),
    );

    _loadExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black, size: 40),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
        title: const Text(
          "Splitify",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  You Owe / You Owes Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Column(
                    children: [
                      Text("You Owe",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 4),
                      Text("₹300",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    children: [
                      Text("You Owes",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 4),
                      Text("₹450",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            //  Recent Groups
            const Text("Recent Groups",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recentGroups.length,
                itemBuilder: (context, index) {
                  final group = recentGroups[index];
                  return GestureDetector(
                    onTap: () => _openGroup(group),
                    child: Container(
                      width: 120,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 64, 155, 230),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(group['icon'] ?? "💬",
                              style: const TextStyle(
                                  fontSize: 30, color: Colors.white)),
                          const SizedBox(height: 8),
                          Text(group['title'] ?? "Group",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17)),
                          Text(group['date'] ?? "",
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 13)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            //  Recent Expenses (scrollable)
            const Text("Recent Expenses",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: recentExpenses.length,
                itemBuilder: (context, index) {
                  final exp = recentExpenses[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            const Color.fromARGB(255, 127, 142, 168),
                        child: Icon(IconData(exp['icon'],
                            fontFamily: 'MaterialIcons',
                            fontPackage: 'material_icons')),
                      ),
                      title: Text(exp['title']),
                      subtitle: Text(exp['subtitle']),
                      trailing: Text(
                        "₹${exp['amount']}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      //  Floating Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateGroupScreen()),
          );
        },
      ),
    );
  }
}
