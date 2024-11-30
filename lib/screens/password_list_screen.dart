import 'package:flutter/material.dart';
import 'password_detail_screen.dart';
import '../main.dart'; // Import the PasswordEntry class

class PasswordListScreen extends StatefulWidget {
  final String category;
  final List<PasswordEntry> passwords;

  const PasswordListScreen({
    Key? key,
    required this.category,
    required this.passwords,
  }) : super(key: key);

  @override
  _PasswordListScreenState createState() => _PasswordListScreenState();
}

class _PasswordListScreenState extends State<PasswordListScreen> {
  late List<PasswordEntry> categoryPasswords;

  @override
  void initState() {
    super.initState();
    // Filter passwords sesuai kategori saat inisialisasi
    categoryPasswords = widget.passwords
        .where((password) => password.category == widget.category)
        .toList();
  }

  Future<void> _deletePassword(PasswordEntry password) async {
    // Tampilkan dialog konfirmasi hapus
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
      // Hapus entri dari penyimpanan lokal
      await PasswordEntry.deleteEntry(password);

      // Sinkronkan ulang daftar entri dari penyimpanan lokal
      final allPasswords = await PasswordEntry.loadFromStorage();

      setState(() {
        // Perbarui daftar entri di halaman saat ini
        categoryPasswords = allPasswords
            .where((entry) => entry.category == widget.category)
            .toList();

        // Perbarui daftar entri di halaman utama
        widget.passwords.clear();
        widget.passwords.addAll(allPasswords);
      });
    }
  }

  void _updatePassword(
      String oldTitle, String title, String username, String password) async {
    // Muat daftar password dari penyimpanan
    final passwords = await PasswordEntry.loadFromStorage();

    // Temukan dan perbarui entri
    final index = passwords.indexWhere((entry) =>
        entry.title == oldTitle && entry.category == widget.category);
    if (index != -1) {
      passwords[index] = PasswordEntry(
        category: widget.category,
        title: title,
        username: username,
        password: password,
      );

      // Simpan kembali data ke penyimpanan
      await PasswordEntry.saveToStorage(passwords);

      // Perbarui tampilan
      setState(() {
        widget.passwords.clear();
        widget.passwords.addAll(passwords);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xff1c4475),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kategori Aplikasi :',
              style: TextStyle(
                  color: Color(0xff1c4475), fontWeight: FontWeight.bold),
            ),
            Text(widget.category,
                style: const TextStyle(
                    color: Color(0xff1c4475), fontWeight: FontWeight.bold)),
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
          return Card(
            color: const Color(0xff1c4475),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: GestureDetector(
                child: Text(
                  password.title,
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PasswordDetailScreen(
                        title: password.title,
                        category: password.category,
                        username: password.username,
                        password: password.password,
                        onSave:
                            (updatedTitle, updatedUsername, updatedPassword) {
                          _updatePassword(password.title, updatedTitle,
                              updatedUsername, updatedPassword);
                        },
                      ),
                    ),
                  ).then((_) async {
                    // Perbarui daftar password setelah kembali
                    final updatedPasswords = await PasswordEntry.loadFromStorage();
                    setState(() {
                      categoryPasswords = updatedPasswords; // Pastikan variabel passwords adalah List<PasswordEntry>
                    });
                  });
                },
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onPressed: () => _deletePassword(password),
              ),
            ),
          );
        },
      ),
    );
  }
}
