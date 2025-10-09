// lib/home/settlement_bottom.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settleup.dart';

class SettlementBottom extends StatefulWidget {
  const SettlementBottom({Key? key}) : super(key: key);

  @override
  State<SettlementBottom> createState() => _SettlementBottomState();
}

class _SettlementBottomState extends State<SettlementBottom> {
  List<Map<String, dynamic>> groupsList = [];
  Map<String, List<Map<String, dynamic>>> settlementHistory = {};

  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  Future<void> _loadGroups() async {
    final prefs = await SharedPreferences.getInstance();
    final savedGroups = prefs.getString('groupsList');
    if (savedGroups != null) {
      groupsList = (jsonDecode(savedGroups) as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    } else {
      groupsList = [];
    }

    // Load expenses for each group
    for (var g in groupsList) {
      final groupId = g['id'] ?? '';
      final savedGroupData = prefs.getString('group_$groupId');
      if (savedGroupData != null) {
        final data = jsonDecode(savedGroupData);
        g['expenses'] = (data['expenses'] as List)
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
      } else {
        g['expenses'] = [];
      }
    }

    setState(() {});
  }

  double _getPerPersonAmount(Map<String, dynamic> expense, int memberCount) {
    final amountRaw = expense['amount'];
    double amount =
        amountRaw is int ? amountRaw.toDouble() : amountRaw as double;
    return amount / memberCount;
  }

  Future<void> _saveGroups() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('groupsList', jsonEncode(groupsList));
  }

  Future<void> _saveSettlementHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('settlementHistory', jsonEncode(settlementHistory));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Settlement'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: groupsList.isEmpty
          ? const Center(child: Text("No groups found"))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: groupsList.map<Widget>((g) {
                  final groupName = g['title'] ?? 'Unnamed Group';
                  final transactions = (g['expenses'] as List<dynamic>? ?? [])
                      .map((e) => Map<String, dynamic>.from(e))
                      .toList();
                  final memberCount = (g['members'] as List<dynamic>? ??
                          ['Amit', 'Neha', 'Ravi', 'Rahul'])
                      .length;

                  double balance = 0.0;
                  for (var t in transactions) {
                    balance += _getPerPersonAmount(t, memberCount);
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Colors.indigo,
                            ),
                            child: const Text(
                              'Settlement',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          groupName,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Total Balance ₹${balance.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black26),
                          ),
                          child: Column(
                            children: transactions.map<Widget>((t) {
                              final perPersonAmount =
                                  _getPerPersonAmount(t, memberCount);
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 12),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${t['paidBy']} owes ₹${perPersonAmount.toStringAsFixed(2)}",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SettleUpScreen(
                                              payer: t['paidBy'],
                                              receiver: '',
                                              group: groupName,
                                              amount: perPersonAmount,
                                            ),
                                          ),
                                        );

                                        if (result == true) {
                                          setState(() {
                                            transactions.remove(t);

                                            // Add to settlement history
                                            if (!settlementHistory
                                                .containsKey(groupName)) {
                                              settlementHistory[groupName] = [];
                                            }
                                            settlementHistory[groupName]!.add({
                                              'payer': t['paidBy'],
                                              'receiver': '',
                                              'amount': perPersonAmount,
                                              'date': DateTime.now().toString(),
                                            });

                                            g['expenses'] = transactions;
                                            _saveGroups();
                                            _saveSettlementHistory();
                                          });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        backgroundColor: Colors.indigo,
                                      ),
                                      child: const Text(
                                        'Settle',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }
}
