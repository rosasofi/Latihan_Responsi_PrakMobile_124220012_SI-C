import 'package:flutter/material.dart';
import 'package:latihanresponsi/hiveDatabase.dart';
import 'package:latihanresponsi/menu_utama.dart';
import 'signUpPage.dart';
import '../dataModel.dart';

class LoginPageFul extends StatefulWidget {
  const LoginPageFul({Key? key}) : super(key: key);

  @override
  _LoginPageFulState createState() => _LoginPageFulState();
}

class _LoginPageFulState extends State<LoginPageFul> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void validateAndSave() {
    final FormState? form = _formKey.currentState;
    if (form != null) {
      if (form.validate()) {
        print('Form is valid');
      } else {
        print('Form is invalid');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background dengan gambar NASA
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/nasa_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Lapisan semi-transparan
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          // Konten utama
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Logo NASA

                    const SizedBox(height: 20),

                    // Welcome message
                    const Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Additional message
                    Text(
                      "Log in to explore the universe",
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
                      validator: (value) =>
                          value!.isEmpty ? 'Username cannot be blank' : null,
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
                      validator: (value) =>
                          value!.isEmpty ? 'Password cannot be blank' : null,
                    ),
                    const SizedBox(height: 30),

                    // Login Button
                    _buildLoginButton(),
                    const SizedBox(height: 20),

                    // Register Button
                    _buildRegisterButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 44, 91, 129),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        "Login",
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      onPressed: () {
        validateAndSave();
        String currentUsername = _usernameController.value.text;
        String currentPassword = _passwordController.value.text;

        _processLogin(currentUsername, currentPassword);
      },
    );
  }

  void _processLogin(String username, String password) async {
    final HiveDatabase _hive = HiveDatabase();
    bool found = false;

    print('Username: $username');
    print('Password: $password');
    print('Encrypted Password: ${DataModel.encryptPassword(password)}');

    found = _hive.checkLogin(username, password);

    if (!found) {
      showAlertDialog(context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MenuUtama(),
        ),
      );

      SnackBar snackBar = SnackBar(
        content: const Text("Login Success!"),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Widget _buildRegisterButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Teks "Don't have an account?"
          const Text(
            "Don't have an account?",
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 5),
          // Tombol "Sign Up"
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SignUp(),
                ),
              );
            },
            child: const Text(
              "Sign Up",
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
    );
  }

  void showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: const Text(
        "Login Failed!",
        style: TextStyle(
          fontFamily: "Montserrat",
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 20, 48, 100),
        ),
      ),
      content: const Text(
        "Your account is not found",
        style: TextStyle(color: Color.fromARGB(255, 19, 59, 115)),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
