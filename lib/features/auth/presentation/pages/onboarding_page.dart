import 'package:flutter/material.dart';
import 'login_page.dart';
import 'signup_page.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Section: Logo & Tagline
            Column(
              children: [
                const SizedBox(height: 40),
                Image.asset(
                  'assets/images/quizitt_mascot.png',
                  height: 250,
                ),
                const SizedBox(height: 10),
                Image.asset(
                  'assets/images/logo.png',
                  height: 60,
                  width: 150,
                ),
                const SizedBox(height: 10),
                const Text(
                  "The fun way to get serious about studying!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),

            // Bottom Section: Buttons
            Column(
              children: [
                GradientButton(
                  text: "Login",
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                  ),
                ),
                const SizedBox(height: 16),
                GradientButton(
                  text: "Signup",
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignupPage()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFCB6BE6), Color(0xFF1F64E4)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: const Color(0x66000000), // #00000040 (40% opacity black)
            width: 3,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
