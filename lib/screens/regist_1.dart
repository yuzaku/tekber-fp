import 'package:flutter/material.dart';
import 'package:passmanager/screens/regist_2.dart';

class Regist_1 extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Regist_1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Latar belakang putih
        scrolledUnderElevation: 0,
        elevation: 0, // Hilangkan bayangan
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back, color: Colors.black), // Tombol back
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20), // Beri jarak dari atas
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
              // Judul
              const Text(
                'Register',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Color(0xff82A1D1),
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 20),
              // Input Form Container
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: const Color(0xff82A1D1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Username Input
                    const Text(
                      'Enter Username',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Montserrat',
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
                          horizontal: 10,
                          vertical: 8,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Password Input
                    const Text(
                      'Enter Passcode',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,                        
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: passwordController,
                      obscureText: true, // Sembunyikan teks untuk passcode
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Continue Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to the next screen with username and password
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AuthenticationRegistration(
                                username: usernameController.text,
                                password: passwordController.text,
                              ),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0xff8A9586),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Continue',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Footer Text
                    const Center(
                      child: Text(
                        '“Organize smarter, secure better—\nEFO has you covered.”',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32)
            ],
          ),
        ),
      ),
    );
  }
}
