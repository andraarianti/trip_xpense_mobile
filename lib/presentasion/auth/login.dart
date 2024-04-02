import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../domain/usecase/login_usecase.dart';
import '../main.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginUseCase = Provider.of<LoginUseCase>(context);

    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              child: Center(
                child: Image.asset('assets/images/login.png'),
              ),
            ),
            Center(
              child: Text(
                'Welcome to Trip Xpense Admin',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(), // Added outline border
              ),
            ),
            SizedBox(height: 12), // Added space between text fields
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(), // Added outline border
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Ambil nilai dari input
                String username = usernameController.text.trim();
                String password = passwordController.text.trim();

                // Lakukan validasi input
                if (username.isEmpty || password.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('Username dan password harus diisi.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                  return;
                }

                // Panggil use case untuk login
                try {
                  await loginUseCase.login(username, password);
                  // Navigasi ke halaman utama (BottomNavigationBar)
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BottomNavigation()),
                  );
                } catch (e) {
                  // Tangani kesalahan login
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('Gagal login. Periksa kembali username dan password Anda. Error : ${e}'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
