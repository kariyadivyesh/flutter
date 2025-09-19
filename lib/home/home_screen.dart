import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> groups = [
    {"name": "Goa Trip", "icon": Icons.beach_access, "time": "4 days ago"},
    {"name": "Movie", "icon": Icons.movie, "time": "1 week ago"},
    {"name": "Shopping", "icon": Icons.shopping_bag, "time": "2 weeks ago"},
    {"name": "Office", "icon": Icons.work, "time": "1 month ago"},
  ];

  final List<Map<String, dynamic>> expenses = [
    {
      "title": "Dinner",
      "amount": 500,
      "subtitle": "Yesterday ~ You Paid",
      "icon": Icons.restaurant
    },
    {
      "title": "Grocery",
      "amount": 1200,
      "subtitle": "2 weeks ago ~ Amit Paid",
      "icon": Icons.shopping_cart
    },
    {
      "title": "Coffee",
      "amount": 200,
      "subtitle": "2 weeks ago ~ You Paid",
      "icon": Icons.local_cafe
    },
    {
      "title": "Snacks",
      "amount": 300,
      "subtitle": "3 weeks ago ~ Rahul Paid",
      "icon": Icons.fastfood
    },
    {
      "title": "Taxi",
      "amount": 400,
      "subtitle": "1 month ago ~ Neha Paid",
      "icon": Icons.local_taxi
    },
    {
      "title": "Hotel",
      "amount": 2500,
      "subtitle": "1 month ago ~ You Paid",
      "icon": Icons.hotel
    },
    {
      "title": "Tickets",
      "amount": 800,
      "subtitle": "2 months ago ~ Amit Paid",
      "icon": Icons.airplane_ticket
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background white
      appBar: AppBar(
        automaticallyImplyLeading: false, // removes back arrow
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Row(
          children: [
            const Text(
              "Splitify",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(
              width: 100,
            ),
            Icon(Icons.person)
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // You Owe / You Owes Card
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

            // Recent Groups
            const Text("Recent Groups",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 120,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 64, 155, 230),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(groups[index]['icon'],
                            size: 30, color: Colors.white),
                        const SizedBox(height: 8),
                        Text(groups[index]['name'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17)),
                        Text(groups[index]['time'],
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Recent Expenses
            const Text("Recent Expenses",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            const Color.fromARGB(255, 127, 142, 168),
                        child: Icon(expenses[index]['icon'],
                            color: Colors.white, size: 20),
                      ),
                      title: Text(expenses[index]['title']),
                      subtitle: Text(expenses[index]['subtitle']),
                      trailing: Text(
                        "₹${expenses[index]['amount']}",
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

      // Floating Add Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
        onPressed: () {},
      ),

      // Bottom Nav Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Groups"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Notifications"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}
