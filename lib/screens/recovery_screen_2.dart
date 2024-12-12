import 'package:flutter/material.dart';
import 'package:passmanager/screens/login_1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RecoveryScreen2 extends StatefulWidget {
  @override
  _RecoveryScreenState2 createState() => _RecoveryScreenState2();
}

class _RecoveryScreenState2 extends State<RecoveryScreen2> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void _onConfirmPressed() async {
    final newUsername = usernameController.text.trim();
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (newPassword == confirmPassword) {
      final prefs = await SharedPreferences.getInstance();
      final oldUsername = prefs.getString('username'); // Ambil username lama
      await prefs.setString('username', newUsername);
      await prefs.setString('password', newPassword);

      // Perbarui ownerusername pada PasswordEntry
      if (oldUsername != null) {
        updateOwnerUsername(oldUsername, newUsername);
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User Data Succesfully Reset')),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password Doesn\'t Match')),
      );
    }
  }

  void updateOwnerUsername(String oldUsername, String newUsername) async {
    final prefs = await SharedPreferences.getInstance();
    final passwordListJson = prefs.getString('password_entries');

    if (passwordListJson != null) {
      final List<dynamic> passwordData = json.decode(passwordListJson);

      // Pastikan passwordData adalah List
      final updatedList = passwordData.map((entry) {
        // Pastikan setiap entry adalah Map sebelum memproses
        if (entry is Map<String, dynamic>) {
          if (entry['ownerUsername'] == oldUsername) {
            entry['ownerUsername'] = newUsername;
          }
        }
        return entry;
      }).toList();

      // Simpan kembali data yang telah diperbarui
      await prefs.setString('password_entries', json.encode(updatedList));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Hindari mengambil seluruh tinggi layar
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Image.asset(
                  'assets/logo_nama.png',
                  width: 300,
                  height: 300,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                decoration: const BoxDecoration(
                  color: Color(0xffdf8787),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: const Text(
                  'Recovery Mode',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Input Form
              Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff8A9586),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Enter Your New Username',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Enter Your New Password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: newPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Confirm Your New Password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: _onConfirmPressed,
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xff82A1D1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Confirm',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
