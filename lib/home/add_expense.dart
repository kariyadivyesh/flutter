import 'package:flutter/material.dart';
import 'package:splitify/home/custom_split.dart';

class AddExpensesScreen extends StatefulWidget {
  const AddExpensesScreen({super.key});

  @override
  _AddExpensesScreenState createState() => _AddExpensesScreenState();
}

class _AddExpensesScreenState extends State<AddExpensesScreen> {
  String _splitType = 'Equally';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Screen background is white
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.white, // AppBar background is white
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Center(
          child: Text(
            'Add Expenses',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFormSection('Title', 'Enter a Title'),
              _buildFormSection('Amount', 'Enter Amount'),
              _buildFormSection('Date', 'Select Date'),
              const SizedBox(height: 20),
              // Paid by
              const Text(
                'Paid by',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('Rahul', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 20),
              // Split
              const Text(
                'Split',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _splitType = 'Equally';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _splitType == 'Equally'
                            ? const Color.fromARGB(255, 95, 87, 241)
                            : Colors.grey.shade200,
                        foregroundColor: _splitType == 'Equally'
                            ? Colors.white
                            : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: _splitType == 'Equally'
                                ? Colors.transparent
                                : Colors.grey.shade400,
                          ),
                        ),
                      ),
                      child: const Text('Equally'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomExpensesScreen()));
                        setState(() {
                          _splitType = 'Custom';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _splitType == 'Custom'
                            ? const Color.fromARGB(255, 95, 87, 241)
                            : Colors.grey.shade200,
                        foregroundColor: _splitType == 'Custom'
                            ? Colors.white
                            : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: _splitType == 'Custom'
                                ? Colors.transparent
                                : Colors.grey.shade400,
                          ),
                        ),
                      ),
                      child: const Text('Custom'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // Save Button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 95, 87, 241),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Save', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormSection(String label, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            hintText,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
