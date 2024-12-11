import 'package:flutter/material.dart';
import 'package:passmanager/screens/welcome_screen.dart';
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

class PasswordEntry {
  String category;
  String title;
  String username;
  String password;
  final String ownerUsername;

  PasswordEntry({
    required this.category,
    required this.title,
    required this.username,
    required this.password,
    required this.ownerUsername,
  });

  // Konversi ke Map (JSON)
  Map<String, dynamic> toJson() => {
        'category': category,
        'title': title,
        'username': username,
        'password': password,
        'ownerUsername': ownerUsername,
      };

  // Konversi dari Map (JSON)
  factory PasswordEntry.fromJson(Map<String, dynamic> json) => PasswordEntry(
        category: json['category'],
        title: json['title'],
        username: json['username'],
        password: json['password'],
        ownerUsername: json['ownerUsername'],
      );

  /// Muat semua password untuk pengguna tertentu
  static Future<List<PasswordEntry>> loadFromStorage(String ownerUsername) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('password_entries');
    if (jsonString == null) {
      return [];
    }
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList
        .map((json) => PasswordEntry.fromJson(json))
        .where((entry) => entry.ownerUsername == ownerUsername)
        .toList();
  }

  /// Simpan daftar password ke penyimpanan
  static Future<void> saveToStorage(List<PasswordEntry> entries) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(entries.map((e) => e.toJson()).toList());
    await prefs.setString('password_entries', jsonString);
  }

  /// Tambahkan password baru untuk pengguna tertentu
  static Future<void> addEntry(PasswordEntry entry) async {
    final entries = await loadFromStorage(entry.ownerUsername);
    entries.add(entry);
    await saveToStorage(entries);
  }

  /// Perbarui entri password
  static Future<void> updateEntry(
      PasswordEntry oldEntry, PasswordEntry updatedEntry) async {
    final entries = await loadFromStorage(oldEntry.ownerUsername);
    final index = entries.indexWhere((e) =>
        e.category == oldEntry.category &&
        e.title == oldEntry.title &&
        e.username == oldEntry.username &&
        e.password == oldEntry.password);
    if (index != -1) {
      entries[index] = updatedEntry;
      await saveToStorage(entries);
    }
  }

  /// Hapus password tertentu
  static Future<void> deleteEntry(PasswordEntry entry) async {
    final entries = await loadFromStorage(entry.ownerUsername);
    entries.removeWhere((e) =>
        e.category == entry.category &&
        e.title == entry.title &&
        e.username == entry.username &&
        e.password == entry.password);
    await saveToStorage(entries);
  }
}

