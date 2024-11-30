import 'package:flutter/material.dart';
import 'package:passmanager/main.dart';

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
                decoration:
                    const InputDecoration(labelText: 'Kategori Lainnya'),
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
                final category = _isOther
                    ? _categoryController.text
                    : _selectedCategory ?? '';
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
