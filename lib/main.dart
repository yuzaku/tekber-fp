import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}

// Model untuk menyimpan data password
class PasswordEntry {
  String category;
  String title;
  String username;
  String password;

  PasswordEntry({
    required this.category,
    required this.title,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'category': category,
        'title': title,
        'username': username,
        'password': password,
      };

  factory PasswordEntry.fromJson(Map<String, dynamic> json) => PasswordEntry(
        category: json['category'],
        title: json['title'],
        username: json['username'],
        password: json['password'],
      );
  
  static Future<List<PasswordEntry>> loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('password_entries');
    if (jsonString == null) {
      return [];
    }
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => PasswordEntry.fromJson(json)).toList();
  }

  static Future<void> saveToStorage(List<PasswordEntry> entries) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(entries.map((e) => e.toJson()).toList());
    await prefs.setString('password_entries', jsonString);
  }

  static Future<void> addEntry(PasswordEntry entry) async {
    final entries = await loadFromStorage();
    entries.add(entry);
    await saveToStorage(entries);
  }

  static Future<void> updateEntry(
      PasswordEntry oldEntry, PasswordEntry updatedEntry) async {
    final entries = await loadFromStorage();
    final index = entries.indexOf(oldEntry);
    if (index != -1) {
      entries[index] = updatedEntry;
      await saveToStorage(entries);
    }
  }

  static Future<void> deleteEntry(PasswordEntry entry) async {
  final entries = await loadFromStorage();
  entries.removeWhere((e) =>
      e.category == entry.category &&
      e.title == entry.title &&
      e.username == entry.username &&
      e.password == entry.password);
  await saveToStorage(entries); // Simpan ulang data setelah penghapusan
}
}
