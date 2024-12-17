import 'package:flutter/material.dart';
import 'package:passmanager/screens/welcome_screen.dart';
import 'password_list_screen.dart';
import 'password_add_screen.dart';
import '../main.dart'; // Import the PasswordEntry class

class CategoryListScreen extends StatefulWidget {
  final String loggedInUsername;

  const CategoryListScreen({Key? key, required this.loggedInUsername})
      : super(key: key);

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
    final loadedPasswords =
        await PasswordEntry.loadFromStorage(widget.loggedInUsername);
    final filteredPasswords = loadedPasswords
        .where((entry) => entry.ownerUsername == widget.loggedInUsername)
        .toList();

    setState(() {
      _passwords = filteredPasswords;
      _categories = _passwords.map((e) => e.category).toSet();
    });
  }

  void _navigateToPasswordList(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PasswordListScreen(
          loggedInUsername: widget.loggedInUsername,
          category: category,
          passwords: _passwords,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: const Text('Konfirmasi Keluar'),
              content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
              actions: [
                TextButton(
                  onPressed: () {
                    // Tombol Batal
                    Navigator.of(context).pop(); // Tutup dialog
                  },
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Tombol Ya, keluar ke welcome screen
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomeScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.red, // Warna merah untuk aksi penting
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Ya'),
                ),
              ],
            ),
          );
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 120,
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
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
                          loggedInUsername: widget.loggedInUsername,
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
        ));
  }
}
