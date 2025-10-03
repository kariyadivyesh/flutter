import 'package:flutter/material.dart';

class NotificationBottom extends StatelessWidget {
  const NotificationBottom({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for a large number of notifications to demonstrate scrolling
    final List<Map<String, String>> notifications = List.generate(
      20, // 20 dummy notifications
      (index) {
        if (index % 4 == 0) {
          return {
            'title': 'Rahul added',
            'subtitle': 'Dinner Expenses In Goa Trip',
            'time': '${(index % 5) + 2}h ago',
          };
        } else if (index % 4 == 1) {
          return {
            'title': 'Amit Settled',
            'subtitle': '₹400 with Neha in Movie',
            'time': '${(index % 3) + 1}D ago',
          };
        } else if (index % 4 == 2) {
          return {
            'title': 'Amit added',
            'subtitle': 'Groceries Expenses In Goa Trip',
            'time': '${(index % 5) + 3}h ago',
          };
        } else {
          return {
            'title': 'Neha added',
            'subtitle': 'Dinner Expenses In Movie',
            'time': '${(index % 3) + 5}D ago',
          };
        }
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 90,
        centerTitle: true,
        title: const Text(
          "NOTIFICATIONS",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return _buildNotificationItem(
            notification['title']!,
            notification['subtitle']!,
            notification['time']!,
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }

  Widget _buildNotificationItem(String title, String subtitle, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          Text(
            time,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
