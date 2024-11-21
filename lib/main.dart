import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

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
      home: const CategoryListScreen(),
    );
  }
}

// Model untuk menyimpan data password
class PasswordEntry {
  final String category;
  final String title;
  final String username;
  final String password;

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
}

// Screen Daftar Kategori
class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({Key? key}) : super(key: key);

  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  final _storage = const FlutterSecureStorage();
  List<PasswordEntry> _passwords = [];
  Set<String> _categories = {};

  @override
  void initState() {
    super.initState();
    _loadPasswords();
  }

  Future<void> _loadPasswords() async {
    final passwordsString = await _storage.read(key: 'passwords');
    if (passwordsString != null) {
      final passwordsList = jsonDecode(passwordsString) as List;
      setState(() {
        _passwords = passwordsList
            .map((e) => PasswordEntry.fromJson(e as Map<String, dynamic>))
            .toList();
        _categories = _passwords.map((e) => e.category).toSet();
      });
    }
  }

  void _navigateToPasswordList(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PasswordListScreen(
          category: category,
          passwords: _passwords,
          onDelete: _deletePassword,
        ),
      ),
    );
  }

  Future<void> _deletePassword(PasswordEntry entry) async {
    setState(() {
      _passwords.remove(entry);
      _categories = _passwords.map((e) => e.category).toSet();
    });
    await _savePasswords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori Password'),
      ),
      body: ListView(
        children: _categories.map((category) {
          return ListTile(
            title: Text(category),
            onTap: () => _navigateToPasswordList(category),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPasswordScreen(
                onSave: (entry) {
                  setState(() {
                    _passwords.add(entry);
                    _categories.add(entry.category);
                  });
                  _savePasswords();
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _savePasswords() async {
    final passwordsJson = _passwords.map((e) => e.toJson()).toList();
    await _storage.write(key: 'passwords', value: jsonEncode(passwordsJson));
  }
}

// Screen Daftar Password untuk Kategori Tertentu
class PasswordListScreen extends StatelessWidget {
  final String category;
  final List<PasswordEntry> passwords;
  final Future<void> Function(PasswordEntry) onDelete;

  const PasswordListScreen({
    Key? key,
    required this.category,
    required this.passwords,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryPasswords = passwords.where((e) => e.category == category).toList();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xff1c4475),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kategori Aplikasi :', style: TextStyle(color: Color(0xff1c4475), fontWeight: FontWeight.bold), 
            ),
            Text(
              category, style: const TextStyle(color: Color(0xff1c4475), fontWeight: FontWeight.bold)
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/logo_ig.png',
              height: 60,
              width: 60,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: categoryPasswords.length,
        itemBuilder: (context, index) {
          final password = categoryPasswords[index];
          return Container(
            color: const Color(0xff1c4475),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: ListTile(
              title: GestureDetector(
                child: Text(password.title, style: const TextStyle(color: Colors.white),),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(password.title),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Username: ${password.username}'),
                          Text('Password: ${password.password}'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Tutup'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.white,),
                onPressed: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Konfirmasi Hapus'),
                      content: const Text('Apakah Anda yakin ingin menghapus entri ini?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Hapus'),
                        ),
                      ],
                    ),
                  );

                  if (confirmed == true) {
                    await onDelete(password);
                    Navigator.pop(context, password);
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}



// Halaman untuk menambahkan password baru
class AddPasswordScreen extends StatefulWidget {
  final void Function(PasswordEntry) onSave;

  const AddPasswordScreen({Key? key, required this.onSave}) : super(key: key);

  @override
  _AddPasswordScreenState createState() => _AddPasswordScreenState();
}

class _AddPasswordScreenState extends State<AddPasswordScreen> {
  final _categoryController = TextEditingController();
  final _titleController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedCategory;
  bool _isOther = false;

  final List<String> _categories = [
    'Instagram',
    'X',
    'Discord',
    'Gmail',
    'Github',
    'Linkedin',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Password Baru'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              items: _categories
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                  _isOther = value == 'Other';
                });
              },
              decoration: const InputDecoration(labelText: 'Kategori'),
            ),
            if (_isOther)
              TextField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Kategori Lainnya'),
              ),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final category = _isOther ? _categoryController.text : _selectedCategory ?? '';
                final entry = PasswordEntry(
                  category: category,
                  title: _titleController.text,
                  username: _usernameController.text,
                  password: _passwordController.text,
                );
                widget.onSave(entry);
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
