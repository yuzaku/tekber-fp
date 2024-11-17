// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';
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
      home: const LoginScreen(),
    );
  }
}

// Model untuk menyimpan data password
class PasswordEntry {
  final String title;
  final String username;
  final String password;

  PasswordEntry({
    required this.title,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'username': username,
    'password': password,
  };

  factory PasswordEntry.fromJson(Map<String, dynamic> json) => PasswordEntry(
    title: json['title'],
    username: json['username'],
    password: json['password'],
  );
}

// Screen Login
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _storage = const FlutterSecureStorage();
  final _masterPasswordController = TextEditingController();
  bool _isFirstTime = true;

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  Future<void> _checkFirstTime() async {
    final masterPassword = await _storage.read(key: 'master_password');
    setState(() {
      _isFirstTime = masterPassword == null;
    });
  }

  Future<void> _handleSubmit() async {
    final password = _masterPasswordController.text;
    if (password.isEmpty) return;

    if (_isFirstTime) {
      final hashedPassword = sha256.convert(utf8.encode(password)).toString();
      await _storage.write(key: 'master_password', value: hashedPassword);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PasswordListScreen()),
      );
    } else {
      final storedPassword = await _storage.read(key: 'master_password');
      final hashedInput = sha256.convert(utf8.encode(password)).toString();
      
      if (hashedInput == storedPassword) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PasswordListScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password salah!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isFirstTime ? 'Buat Master Password' : 'Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _masterPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: _isFirstTime ? 'Buat master password' : 'Masukkan master password',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _handleSubmit,
              child: Text(_isFirstTime ? 'Buat' : 'Login'),
            ),
          ],
        ),
      ),
    );
  }
}

// Screen Daftar Password
class PasswordListScreen extends StatefulWidget {
  const PasswordListScreen({Key? key}) : super(key: key);

  @override
  _PasswordListScreenState createState() => _PasswordListScreenState();
}

class _PasswordListScreenState extends State<PasswordListScreen> {
  final _storage = const FlutterSecureStorage();
  List<PasswordEntry> _passwords = [];

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
      });
    }
  }

  Future<void> _savePasswords() async {
    final passwordsJson = _passwords.map((e) => e.toJson()).toList();
    await _storage.write(key: 'passwords', value: jsonEncode(passwordsJson));
  }

  Future<void> _addPassword() async {
    final titleController = TextEditingController();
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Password Baru'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _passwords.add(PasswordEntry(
                  title: titleController.text,
                  username: usernameController.text,
                  password: passwordController.text,
                ));
              });
              _savePasswords();
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Password'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _passwords.length,
        itemBuilder: (context, index) {
          final password = _passwords[index];
          return ListTile(
            title: Text(password.title),
            subtitle: Text(password.username),
            trailing: IconButton(
              icon: const Icon(Icons.visibility),
              onPressed: () {
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPassword,
        child: const Icon(Icons.add),
      ),
    );
  }
}