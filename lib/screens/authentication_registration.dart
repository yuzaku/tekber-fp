import 'package:flutter/material.dart';
import 'package:passmanager/screens/regist_3.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRegistration extends StatelessWidget {
  final String username;
  final String password;

  AuthenticationRegistration(
      {required this.username, required this.password, super.key});

  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController birthPlaceController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  Future<void> saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
    await prefs.setString('fullname', fullnameController.text);
    await prefs.setString('birthPlace', birthPlaceController.text);
    await prefs.setString('birthDate', birthDateController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Logo Section
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/logo_nama.png',
                      width: 300,
                      height: 300,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Authentication Form Container
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 45),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: const BoxDecoration(
                  color: Color(0xffDF8787),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: const Column(
                  children: [
                    Text(
                      'Authentication',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              // Input Form Container
              Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: const BoxDecoration(
                  color: Color(0xff8A9586),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter your Fullname',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: fullnameController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Enter your Birthdate',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: birthDateController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Enter your Birthplace',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: birthPlaceController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () async {
                        await saveUserData();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Regist_3()));
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xff82A1D1),
                        padding: const EdgeInsets.symmetric(vertical: 12),
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
