import 'package:flutter/material.dart';
import '../widgets/auth_input_field.dart';
import 'signup_page.dart';
import 'time_page.dart'; // 👈 Import your onboarding screen

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  void _login() {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const TimePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter email and password")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            Center(
                child: Image.asset(
                    'assets/images/quizitt_mascot.png',
                    height: 100
                )),
            const SizedBox(height: 20),
            const Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),
            AuthInputField(
              hint: "Email Address",
              icon: Icons.email,
              controller: emailController,
            ),
            const SizedBox(height: 12),
            AuthInputField(
              hint: "Password",
              icon: Icons.lock,
              isPassword: true,
              controller: passwordController,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Checkbox(value: rememberMe, onChanged: (val) {
                  setState(() => rememberMe = val ?? false);
                }),
                const Text("Remember Me"),
                const Spacer(),
                TextButton(onPressed: () {}, child: const Text("Forgot Password?")),
              ],
            ),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              child: const Text("Login",
                  style: TextStyle(fontWeight: FontWeight.bold,
                      color: Colors.white,)),
            ),
            const SizedBox(height: 36),
            Row(
              children: [
                const Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey,
                    endIndent: 10, // space between line and text
                  ),
                ),
                const Text(
                  "or continue with",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey), // optional
                ),
                const Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey,
                    indent: 10, // space between text and line
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(Icons.facebook, size: 30),
                Icon(Icons.g_mobiledata, size: 30),
                Icon(Icons.apple, size: 30),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don’t have an account? "),
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupPage())),
                  child: const Text("Sign up", style: TextStyle(color: Colors.purpleAccent)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
