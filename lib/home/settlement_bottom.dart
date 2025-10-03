import 'package:flutter/material.dart';
import 'settleup.dart';

class SettlementBottom extends StatefulWidget {
  const SettlementBottom({Key? key}) : super(key: key);

  @override
  State<SettlementBottom> createState() => _SettlementBottomState();
}

class _SettlementBottomState extends State<SettlementBottom> {
  final List<Map<String, dynamic>> groups = [
    {
      'name': 'Goa Trip',
      'balance': 1600,
      'transactions': [
        {"payer": "Amit", "receiver": "Rahul", "amount": 300},
        {"payer": "Neha", "receiver": "Rahul", "amount": 500},
        {"payer": "Ravi", "receiver": "Rahul", "amount": 800},
      ],
    },
    {
      'name': 'Movie',
      'balance': 500,
      'transactions': [
        {"payer": "John", "receiver": "Neha", "amount": 200},
        {"payer": "Ravi", "receiver": "John", "amount": 300},
      ],
    },
    {
      'name': 'Shopping',
      'balance': 1200,
      'transactions': [
        {"payer": "Neha", "receiver": "Rahul", "amount": 700},
        {"payer": "Amit", "receiver": "Neha", "amount": 500},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Settlement'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: groups.map<Widget>((g) {
            final name = g['name'] as String;
            final balance = g['balance'].toString();
            final transactions =
                (g['transactions'] as List).cast<Map<String, dynamic>>();

            return Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Settlement button (not functional yet)
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
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Group title & balance
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Total Balance $balance',
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
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${t['payer']} owes ${t['receiver']}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SettleUpScreen(
                                          payer: t['payer'],
                                          receiver: t['receiver'],
                                          amount: t['amount'],
                                          group: ''),
                                    ),
                                  );

                                  // If settlement confirmed, remove that transaction
                                  if (result == true) {
                                    setState(() {
                                      transactions.remove(t);
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
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
