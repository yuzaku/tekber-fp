import 'package:flutter/material.dart';
import 'password_list_screen.dart';
import 'password_add_screen.dart';
import '../main.dart'; // Import the PasswordEntry class

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({Key? key}) : super(key: key);

  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  List<PasswordEntry> _passwords = [];
  Set<String> _categories = {};

  @override
  void initState() {
    super.initState();
    _loadPasswords();
  }

  Future<void> _loadPasswords() async {
    final loadedPasswords = await PasswordEntry.loadFromStorage();
    setState(() {
      _passwords = loadedPasswords;
      _categories = _passwords.map((e) => e.category).toSet();
    });
  }

  void _navigateToPasswordList(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PasswordListScreen(
          category: category,
          passwords: _passwords,
        ),
      ),
    );
  }

  Future<void> _deletePassword(PasswordEntry entry) async {
    await PasswordEntry.deleteEntry(entry);
    await _loadPasswords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 120,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/logo_efo_appbar.png',
                  width: 95,
                  height: 95,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ENCRYPTED',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff1C4475),
                      ),
                    ),
                    Text(
                      'FILE',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff1C4475),
                      ),
                    ),
                    Text(
                      'ORGANIZER',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff1C4475),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPasswordScreen(
                      onSave: (entry) async {
                        await PasswordEntry.addEntry(entry);
                        await _loadPasswords();
                      },
                    ),
                  ),
                );
              },
              child: Image.asset(
                'assets/add.png',
                width: 75,
                height: 75,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: _categories.map((category) {
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              color: const Color(0xff1C4475),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: ListTile(
                  title: Text(
                    category,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () => _navigateToPasswordList(category),
                  leading: Image.asset(
                    'assets/logo_ig.png',
                  ),
                  trailing: Image.asset(
                    'assets/arrow.png',
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}