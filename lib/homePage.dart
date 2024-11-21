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
        fontFamily: 'Montserrat'
      ),
      home: const HomePageFPTekber(),
    );
  }
}

class HomePageFPTekber extends StatelessWidget {
  const HomePageFPTekber({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
  toolbarHeight: 120,
  elevation: 0,
  backgroundColor: Colors.white,
  title: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Image.asset(
            'assets/photos/logo_efo_appbar.png',
            width: 95, // Adjust width
            height: 95, // Adjust height
          ), // Add spacing
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'ENCRYPTED',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff1C4475),
                ),
              ),
              Text(
                'FILE',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff1C4475),
                ),
              ),
              Text(
                'ORGANIZER',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff1C4475),
                ),
              ),
            ],
          ),
        ],
      ),
      GestureDetector(
        onTap: () => (),
        child: Image.asset(
          'assets/photos/add.png',
          width: 75,
          height: 75,
          fit: BoxFit.contain,
        ),
      ),
    ],
  ),
),

      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Color(0xff1C4475),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.only(
              top : 4.0,
              bottom: 4.0),
            child: ListTile(
            leading: Image.asset(
             'assets/photos/instagram.png',
            ),
            trailing: Image.asset(
              'assets/photos/arrow.png',
            ),
            ),
          ),
        )
      )
    );
  }
}