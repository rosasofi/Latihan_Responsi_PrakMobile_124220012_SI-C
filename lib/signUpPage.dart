import 'package:flutter/material.dart';
import 'dart:ui'; // Dibutuhkan untuk efek blur
import 'package:latihanresponsi/hiveDatabase.dart';
import 'package:latihanresponsi/dataModel.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final HiveDatabase _hive = HiveDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background dengan gambar
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/nasa_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Efek blur pada latar belakang
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Blur efek
            child: Container(
              color: Colors.black
                  .withOpacity(0.4), // Warna overlay semi-transparan
            ),
          ),
          // Konten utama
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Create Your Account",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Join us to explore the universe",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Username Field
                  TextFormField(
                    controller: _usernameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Username",
                      hintStyle: const TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.grey,
                      ),
                      contentPadding: const EdgeInsets.all(8),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: const TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.grey,
                      ),
                      contentPadding: const EdgeInsets.all(8),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Register Button
                  _buildRegisterButton(),
                  const SizedBox(height: 20),
                  // Back to Login Button
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Back to Login",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 44, 91, 129),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        "Sign Up",
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      onPressed: () {
        if (_usernameController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty) {
          var encryptedPassword =
              DataModel.encryptPassword(_passwordController.text);

          _hive.addData(
            DataModel(
              username: _usernameController.text,
              password: _passwordController.text,
              encryptedPassword: encryptedPassword,
            ),
          );

          _usernameController.clear();
          _passwordController.clear();

          Navigator.pop(context);
        }
      },
    );
  }
}
