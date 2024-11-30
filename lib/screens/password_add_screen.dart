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
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8.0),
              buildLabel('Kategori'),
              buildCard(
                child: DropdownButtonFormField<String>(
                  iconEnabledColor: Colors.white,
                  value: _selectedCategory,
                  items: _categories
                      .map(
                        (e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: const TextStyle(color: Colors.black),
                            )),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                      _isOther = value == 'Other';
                    });
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return _categories.map((e) {
                      return Text(
                        e,
                        style: const TextStyle(
                            color: Colors.white), // Warna setelah dipilih
                      );
                    }).toList();
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                  dropdownColor: Colors.white,
                ),
              ),
              if (_isOther)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8.0),
                    buildLabel('Kategori Lainnya'),
                    buildCardInput(_categoryController),
                  ],
                ),
              const SizedBox(height: 8.0),
              buildLabel('Judul'),
              buildCardInput(_titleController),
              const SizedBox(height: 8.0),
              buildLabel('Username'),
              buildCardInput(_usernameController),
              const SizedBox(height: 8.0),
              buildLabel('Password'),
              buildCardInput(_passwordController, obscureText: true),
              const SizedBox(height: 24.0),
              Card(
                color: Colors.green,
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: TextButton(
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
                  child: const Text(
                    'Simpan',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget buildLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF003B5C),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildCardInput(TextEditingController controller,
      {bool obscureText = false}) {
    return Container(
      color: Colors.white,
      child: Card(
        color: const Color(0xff1C4475),
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCard({required Widget child}) {
    return Card(
      color: const Color(0xff1C4475),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: child,
      ),
    );
  }
}
