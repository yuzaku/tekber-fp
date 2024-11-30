import 'package:flutter/material.dart';

class PasswordDetailScreen extends StatefulWidget {
  final String title;
  final String category;
  final String username;
  final String password;
  final Function(String title, String username, String password) onSave;

  const PasswordDetailScreen({
    Key? key,
    required this.title,
    required this.category,
    required this.username,
    required this.password,
    required this.onSave,
  }) : super(key: key);

  @override
  State<PasswordDetailScreen> createState() => _PasswordDetailScreenState();
}

class _PasswordDetailScreenState extends State<PasswordDetailScreen> {
  late TextEditingController _titleController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _usernameController = TextEditingController(text: widget.username);
    _passwordController = TextEditingController(text: widget.password);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color(0xff1c4475),
        ),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            _titleController.text,
            style: const TextStyle(
                color: Color(0xff1c4475), fontWeight: FontWeight.bold),
          ),
          const Text('Details',
              style: TextStyle(
                  color: Color(0xff1c4475), fontWeight: FontWeight.bold)),
        ]),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8.0),
              buildLabel('Judul'),
              buildCardInput(_titleController),
              const SizedBox(height: 8.0),
              buildLabel('Email/Username'),
              buildCardInput(_usernameController),
              const SizedBox(height: 8.0),
              buildLabel('Password'),
              buildCardInput(_passwordController),
              const SizedBox(height: 24.0),
              Card(
                color: const Color(0xff1C4475),
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: TextButton(
                  onPressed: () {
                    if (_isEditing) {
                      // Simpan perubahan dan panggil callback
                      widget.onSave(
                        _titleController.text,
                        _usernameController.text,
                        _passwordController.text,
                      );

                      // Tampilkan SnackBar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Perubahan berhasil disimpan!'),
                          duration: Duration(seconds: 2),
                        ),
                      );

                      // Nonaktifkan mode edit
                      setState(() {
                        _isEditing = false;
                      });
                    } else {
                      // Aktifkan mode edit
                      setState(() {
                        _isEditing = true;
                      });
                    }
                  },
                  child: Text(
                    _isEditing ? 'Save' : 'Edit',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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

  Widget buildCardInput(TextEditingController controller) {
    return Container(
      color: Colors.white,
      child: Card(
        color: const Color(0xff1C4475),
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: TextFormField(
            controller: controller,
            readOnly: !_isEditing,
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
}
