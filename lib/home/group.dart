import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitify/home/add_expense.dart';

class Group extends StatefulWidget {
  final String groupName;
  final String groupId;

  const Group({
    super.key,
    required this.groupName,
    required this.groupId,
  });

  @override
  State<Group> createState() => _GroupState();
}

class _GroupState extends State<Group> {
  List<String> groupMembers = ["Neha", "Rahul", "Amit", "Ravi"];
  List<Map<String, dynamic>> expenses = [];
  double totalAmount = 0.0;
  double youOwe = 0.0;
  double youOwed = 0.0;

  @override
  void initState() {
    super.initState();
    _loadGroupData();
  }

  Future<void> _loadGroupData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString('group_${widget.groupId}');
    if (savedData != null) {
      final data = jsonDecode(savedData);
      setState(() {
        expenses = (data['expenses'] as List)
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
        totalAmount = data['totalAmount'] ?? 0.0;
        youOwe = data['youOwe'] ?? 0.0;
        youOwed = data['youOwed'] ?? 0.0;
      });
    }
  }

  Future<void> _saveGroupData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = {
      'expenses': expenses,
      'totalAmount': totalAmount,
      'youOwe': youOwe,
      'youOwed': youOwed,
    };
    await prefs.setString('group_${widget.groupId}', jsonEncode(data));
  }

  void _addExpense(Map<String, dynamic> expense) {
    setState(() {
      expenses.add(expense);
      totalAmount += expense['amount'];
      _calculateBalances();
    });
    _saveGroupData();
  }

  void _calculateBalances() {
    // Calculate how much Neha owes or is owed
    double nehaShare = 0.0;
    double nehaPaid = 0.0;

    for (var exp in expenses) {
      double sharePerPerson = exp['amount'] / groupMembers.length;
      if (exp['paidBy'] == 'Neha') {
        nehaPaid += exp['amount'];
      }
      nehaShare += sharePerPerson;
    }

    double balance = nehaPaid - nehaShare;
    if (balance > 0) {
      youOwed = balance;
      youOwe = 0.0;
    } else {
      youOwed = 0.0;
      youOwe = balance.abs();
    }
  }

  void _openAddExpenseScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddExpensesScreen(groupMembers: groupMembers),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      _addExpense(result);
    }
  }

  void _leaveGroup() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('group_${widget.groupId}');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("You left the group")),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          widget.groupName.toUpperCase(),
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Group ID
            TextField(
              enabled: false,
              controller: TextEditingController(text: widget.groupId),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Total container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text("Total",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                  const SizedBox(height: 8),
                  Text("₹${totalAmount.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text("Your Owe",
                              style: TextStyle(fontSize: 20)),
                          const SizedBox(height: 4),
                          Text("₹${youOwe.toStringAsFixed(2)}",
                              style: const TextStyle(fontSize: 18)),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("You Owed",
                              style: TextStyle(fontSize: 20)),
                          const SizedBox(height: 4),
                          Text("₹${youOwed.toStringAsFixed(2)}",
                              style: const TextStyle(fontSize: 18)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Members horizontal list
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: groupMembers.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blueGrey),
                    ),
                    child: Center(
                        child: Text(
                      groupMembers[index],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Expenses list
            Expanded(
              child: expenses.isEmpty
                  ? const Center(child: Text("No expenses yet"))
                  : ListView.builder(
                      itemCount: expenses.length,
                      itemBuilder: (context, index) {
                        final exp = expenses[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(exp["title"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Text("₹${exp["amount"]}",
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 20),

            // Leave / Add Expenses buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _leaveGroup,
                    child: const Text("Leave Group",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _openAddExpenseScreen,
                    child: const Text("Add Expenses",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
