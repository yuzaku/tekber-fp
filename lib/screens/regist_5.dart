import 'package:flutter/material.dart';

class Regist_5 extends StatelessWidget {
  const Regist_5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Latar belakang putih
        elevation: 0, // Hilangkan bayangan
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Tombol back
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Posisikan di tengah horizontal
          children: [
            const SizedBox(height: 20), // Beri jarak dari atas
            // Logo Section
            Center( // Gunakan Center untuk memastikan elemen dalam Column berada di tengah horizontal
              child: Image.asset(
                'assets/logo_nama.png',
                width: 300,
                height: 300,
              ),
            ),
            // const SizedBox(height: 20),
            const Text(
              'Login', 
              style: TextStyle(
                fontSize: 50, // Ukuran font
                fontWeight: FontWeight.bold, // Tebal
                fontStyle: FontStyle.italic, // Italic
                color: Color(0xff8A9586), // Warna #8A9586
                fontFamily: 'Montserrat', // Font Montserrat
              ),
            ),
            const Spacer(),
            // Authentication Form Container - Sticks to the bottom
            Container(
              padding: const EdgeInsets.only(
                  top: 8, bottom: 8, left: 20, right: 20),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                color: Color(0xff6BBE3B),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              // Authentication Form
              child: const Column(
                children: [
                  Text(
                    'Passcode Succesfully Reset!',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Montserrat', // Font Montserrat
                    ),
                  ),
                ],
              ),
            ),
            // Input Form Container
            Container(
              padding: const EdgeInsets.only(
                top: 15,
                left: 20,
                right: 20,
                bottom: 15),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: const Color(0xff8A9586),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8)),
              ),
              child: Column(
                children: [
                  // Full Name Text
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Username',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'Montserrat', // Font Montserrat
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Full Name Input
                  TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: InputBorder.none, // Remove outline border
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), // Reduced vertical padding for smaller height
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none, // No border side
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none, // No border side
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Birthdate Text
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Passcode',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Montserrat', // Font Montserrat
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Birthdate Input
                  TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: InputBorder.none, // Remove outline border
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), // Reduced vertical padding for smaller height
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none, // No border side
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none, // No border side
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  // Confirm Button
                  TextButton(
                    onPressed: () {}, // Aksi tombol
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xff82A1D1),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Border radius of 8
                      side: const BorderSide(color: Color(0xff82A1D1), width: 2), // Border color and width
                    ), // Text color
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                      children: [
                        const Text(
                          'Continue',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20, 
                            color: Colors.white,
                            fontFamily: 'Montserrat', // Font Montserrat
                          ),
                        ),
                        Image.asset(
                          'assets/arrow_kategori_b.png', 
                          width: 50, 
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Footer Text
                  const Text(
                    '“Organize smarter, secure better—\nEFO has you covered.”',
                    style: TextStyle(
                      fontSize: 14, // Ukuran font lebih kecil untuk teks penutup
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic, // Italic
                      color: Colors.white,
                      fontFamily: 'Montserrat', // Font Montserrat
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
