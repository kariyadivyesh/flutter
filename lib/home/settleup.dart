import 'package:flutter/material.dart';
import 'settlement_history_screen.dart';

class SettleUpScreen extends StatelessWidget {
  final String payer;
  final String receiver;
  final int amount;
  final String group;

  const SettleUpScreen({
    super.key,
    required this.payer,
    required this.receiver,
    required this.amount,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Settle Up",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 36),
            Container(
              padding: const EdgeInsets.all(110),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    "$payer owes $receiver",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "₹$amount",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Group: $group",
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5B5BFF),
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              ),
              onPressed: () {
                settlementHistory.add({
                  "payer": payer,
                  "receiver": receiver,
                  "amount": amount,
                  "group": group,
                });

                //  Snackbar show
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Record moved to Settlement History"),
                    duration: Duration(seconds: 2),
                  ),
                );

                //  Back to Settlement screen with true
                Navigator.pop(context, true);
              },
              child: const Text(
                "Confirm Settlement",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
