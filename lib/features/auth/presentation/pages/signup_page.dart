import 'package:flutter/material.dart';
import '../widgets/auth_input_field.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            Center(child: Image.asset('assets/images/quizitt_mascot.png', height: 100)),
            const SizedBox(height: 20),
            const Text("Create an account", style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
            const SizedBox(height: 32),
            const AuthInputField(hint: "Name", icon: Icons.person),
            const SizedBox(height: 12),
            const AuthInputField(hint: "Email", icon: Icons.email),
            const SizedBox(height: 12),
            const AuthInputField(hint: "Password", icon: Icons.lock, isPassword: true),
            const SizedBox(height: 12),
            Row(
              children: [
                Checkbox(value: false, onChanged: (_) {}),
                const Expanded(child: Text("Accept terms & condition")),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              child: const Text("Register"),
            ),
            const SizedBox(height: 16),
            const Text("or continue with", textAlign: TextAlign.center),
            const SizedBox(height: 12),
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
                const Text("Already have account? "),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text("Sign In", style: TextStyle(color: Colors.purpleAccent)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
