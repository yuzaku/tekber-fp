import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Encrypted File Organizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat',
      ),
      home: const AuthenticationRegistration(),
    );
  }
}

class AuthenticationRegistration extends StatelessWidget {
  const AuthenticationRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between content
          children: [
            // Logo Section - Content at the top
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  // Logo Image
                  Image.asset(
                    'assets/photos/logo_nama.png',
                    width: 300,
                    height: 300,
                  ),
                ],
              ),
            ),
            Spacer(),
            // Authentication Form Container - Sticks to the bottom
            Container(
              padding: const EdgeInsets.only(
                  top: 8, bottom: 8, left: 45, right: 45),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                color: Color(0xffDF8787),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              // Authentication Form
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
              padding: const EdgeInsets.only(
                top: 15,
                left: 20,
                right: 20,
                bottom: 15),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: const Color(0xff8A9586),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8)),
              ),
              child: Column(
                children: [
                  // Full Name Text
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Enter your Fullname',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8), // Reduced vertical padding for smaller height
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
                      'Enter your Birthdate',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8), // Reduced vertical padding for smaller height
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
                  // Birthplace Text
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Enter your Birthplace',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Birthplace Input
                  TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: InputBorder.none, // Remove outline border
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8), // Reduced vertical padding for smaller height
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
                  const SizedBox(height: 20),
                  // Confirm Button
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xff82A1D1),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Border radius of 8
                      side: BorderSide(color: Color(0xff82A1D1), width: 2), // Border color and width
                    ), // Text color
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                      children: [
                        const Text(
                          'Confirm',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20, 
                            color: Colors.white,
                          ),
                        ),
                        Image.asset(
                          'assets/photos/arrow_kategori_b.png', 
                          width: 50, 
                          height: 50,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}