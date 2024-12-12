import 'package:flutter/material.dart';
import 'password_detail_screen.dart';
import '../main.dart'; // Import the PasswordEntry class

// ignore: must_be_immutable
class PasswordListScreen extends StatefulWidget {
  final String category;
  List<PasswordEntry> passwords;
  final String loggedInUsername;

  PasswordListScreen({
    Key? key,
    required this.category,
    required this.passwords,
    required this.loggedInUsername,
  }) : super(key: key);

  @override
  _PasswordListScreenState createState() => _PasswordListScreenState();
}

class _PasswordListScreenState extends State<PasswordListScreen> {
  late List<PasswordEntry> categoryPasswords;
  final TextEditingController _searchController = TextEditingController();
  List<PasswordEntry> filteredPasswords = [];

  @override
  void initState() {
    super.initState();
    // Filter passwords sesuai kategori saat inisialisasi
    categoryPasswords = widget.passwords
        .where((password) => password.category == widget.category)
        .toList();
    filteredPasswords = categoryPasswords;
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
      final allPasswords = await PasswordEntry.loadFromStorage(widget.loggedInUsername);

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
    // Temukan indeks entri yang akan diupdate di widget.passwords
    final index = widget.passwords.indexWhere((entry) => 
        entry.title == oldTitle && entry.category == widget.category);
    
    if (index != -1) {
      // Buat entri password baru
      final updatedEntry = PasswordEntry(
        ownerUsername: widget.loggedInUsername,
        category: widget.category,
        title: title,
        username: username,
        password: password,
      );

      // Update di penyimpanan lokal
      await PasswordEntry.saveToStorage(widget.passwords);

      // Update di state
      setState(() {
        // Update di widget.passwords
        widget.passwords[index] = updatedEntry;

        // Perbarui categoryPasswords
        categoryPasswords = widget.passwords
            .where((password) => password.category == widget.category)
            .toList();

        // Perbarui filteredPasswords
        _filterPasswords(_searchController.text);
      });
    }
  }

  void _filterPasswords(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredPasswords =
            categoryPasswords; // Jika query kosong, tampilkan semua
      } else {
        filteredPasswords = categoryPasswords.where((entry) {
          return entry.title.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
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
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search by title...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged:
                  _filterPasswords, // Panggil fungsi filter saat input berubah
            ),
          ),

          //Password List
          Expanded(
              child: ListView.builder(
            itemCount: filteredPasswords.length,
            itemBuilder: (context, index) {
              final password = filteredPasswords[index];
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
                            onSave: (updatedTitle, updatedUsername,
                                updatedPassword) {
                              _updatePassword(password.title, updatedTitle,
                                  updatedUsername, updatedPassword);
                            },
                          ),
                        ),
                      ).then((_) async {
                        // Perbarui daftar password setelah kembali
                        final updatedPasswords =
                            await PasswordEntry.loadFromStorage(widget.loggedInUsername);
                        setState(() {
                          categoryPasswords =
                              updatedPasswords; // Pastikan variabel passwords adalah List<PasswordEntry>
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
          ))
        ],
      ),
    );
  }
}
