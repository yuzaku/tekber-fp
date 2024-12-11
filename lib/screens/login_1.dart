import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'category_list_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<bool> _login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString('username');
    final savedPassword = prefs.getString('password');
    return username == savedUsername && password == savedPassword;
  }

  void _onLoginPressed() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    if (await _login(username, password)) {
      // Save login session
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('loggedInUsername', username);

      // Navigate to CategoryListScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CategoryListScreen(loggedInUsername: username),
        ),
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Successful!')),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid username or password!')),
      );
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
              const SizedBox(height: 20),
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Color(0xff8A9586),
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 20),
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
                        'Username',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: _usernameController,
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
                        'Passcode',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: _passwordController,
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
                      onPressed: _onLoginPressed,
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
                            'Continue',
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
                    const Text(
                      '“Organize smarter, secure better—\nEFO has you covered.”',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                      ),
                      textAlign: TextAlign.center,
                    ),
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

// import 'package:flutter/material.dart';
// import 'package:passmanager/screens/category_list_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Login_1 extends StatelessWidget {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   Login_1({super.key});

//   Future<bool> login(String username, String password) async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedUsername = prefs.getString('username');
//     final savedPassword = prefs.getString('password');
//     return username == savedUsername && password == savedPassword;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         scrolledUnderElevation: 0,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             mainAxisSize:
//                 MainAxisSize.min, // Hindari mengambil seluruh tinggi layar
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 20),
//               Center(
//                 child: Image.asset(
//                   'assets/logo_nama.png',
//                   width: 300,
//                   height: 300,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Login',
//                 style: TextStyle(
//                   fontSize: 50,
//                   fontWeight: FontWeight.bold,
//                   fontStyle: FontStyle.italic,
//                   color: Color(0xff8A9586),
//                   fontFamily: 'Montserrat',
//                 ),
//               ),
//               const SizedBox(height: 20),
//               // Input Form
//               Container(
//                 padding: const EdgeInsets.all(15),
//                 margin: const EdgeInsets.symmetric(horizontal: 10),
//                 decoration: BoxDecoration(
//                   color: const Color(0xff8A9586),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Column(
//                   children: [
//                     const Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         'Username',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                           color: Colors.white,
//                           fontFamily: 'Montserrat',
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     TextField(
//                       controller: usernameController,
//                       decoration: InputDecoration(
//                         fillColor: Colors.white,
//                         filled: true,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 8),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     const Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         'Passcode',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                           color: Colors.white,
//                           fontFamily: 'Montserrat',
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     TextField(
//                       controller: passwordController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         fillColor: Colors.white,
//                         filled: true,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 8),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     TextButton(
//                       onPressed: () async {
//                         final isLoggedIn = await login(
//                           usernameController.text,
//                           passwordController.text,
//                         );
//                         if (isLoggedIn) {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => CategoryListScreen(loggedInUsername: )));

//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('Login Successful!')),
//                           );
//                           // Navigate to the home screen
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                                 content: Text('Invalid Username or Password')),
//                           );
//                         }
//                       },
//                       style: TextButton.styleFrom(
//                         backgroundColor: const Color(0xff82A1D1),
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 12, horizontal: 20),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: const Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text(
//                             'Continue',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                               color: Colors.white,
//                               fontFamily: 'Montserrat',
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     const Text(
//                       '“Organize smarter, secure better—\nEFO has you covered.”',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         fontStyle: FontStyle.italic,
//                         color: Colors.white,
//                         fontFamily: 'Montserrat',
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 32),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
