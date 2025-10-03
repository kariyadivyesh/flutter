import 'package:flutter/material.dart';

class CustomExpensesScreen extends StatefulWidget {
  const CustomExpensesScreen({super.key});

  @override
  State<CustomExpensesScreen> createState() => _CustomExpensesScreenState();
}

class _CustomExpensesScreenState extends State<CustomExpensesScreen> {
  final int dinnerAmount = 1200;

  final Map<String, TextEditingController> personControllers = {
    "Amit": TextEditingController(text: "500"),
    "Neha": TextEditingController(text: "300"),
    "Rahul": TextEditingController(text: "400"),
    "Ravi": TextEditingController(text: "0"),
    "Sneha": TextEditingController(text: "0"),
    "John": TextEditingController(text: "0"),
  };

  String paidBy = "Neha";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Custom Split",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Dinner",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  dinnerAmount.toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Person List
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Column(
                children: personControllers.entries.map((entry) {
                  return _buildRow(entry.key, entry.value);
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Total row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  _calculateTotal().toString(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Paid by dropdown
            Row(
              children: [
                const Text(
                  "Paid by : ",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: paidBy,
                  items: personControllers.keys.map((name) {
                    return DropdownMenuItem(value: name, child: Text(name));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      paidBy = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Edit",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Row with editable text field
  Widget _buildRow(String name, TextEditingController controller) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: const TextStyle(fontSize: 16)),
            SizedBox(
              width: 70,
              height: 35,
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Calculate total from all controllers
  int _calculateTotal() {
    int sum = 0;
    for (var c in personControllers.values) {
      int val = int.tryParse(c.text) ?? 0;
      sum += val;
    }
    return sum;
  }

  // Save button logic
  void _onSave() {
    int total = _calculateTotal();
    if (total != dinnerAmount) {
      _showErrorDialog("Amount doesn’t match. Total should be $dinnerAmount");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Expense saved successfully!")),
      );
    }
  }

  // Error dialog
  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Error"),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
