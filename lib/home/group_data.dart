// lib/home/group_data.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

List<Map<String, dynamic>> defaultGroups = [
  {
    "icon": "🏖️",
    "title": "Goa Trip",
    "date": "15 Apr 2024",
    "expenses": [
      {"title": "Dinner", "amount": 1200, "paidBy": "Rahul"},
      {"title": "Taxi", "amount": 800, "paidBy": "Amit"},
    ]
  },
  {
    "icon": "🎬",
    "title": "Movie",
    "date": "12 Apr 2024",
    "expenses": [
      {"title": "Tickets", "amount": 500, "paidBy": "Neha"},
    ]
  },
  {
    "icon": "🛒",
    "title": "Shopping",
    "date": "12 Apr 2024",
    "expenses": [
      {"title": "Mall", "amount": 2000, "paidBy": "Ravi"},
    ]
  },
];

// Load groups from SharedPreferences
Future<List<Map<String, dynamic>>> loadGroupsFromPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  final savedData = prefs.getString('groupsList');
  if (savedData != null) {
    final decoded = jsonDecode(savedData) as List;
    return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
  }
  return defaultGroups;
}

// Save groups to SharedPreferences
Future<void> saveGroupsToPrefs(List<Map<String, dynamic>> updatedGroups) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('groupsList', jsonEncode(updatedGroups));
}
