import 'package:flutter/material.dart';
import 'login_page.dart'; // Replace with your actual LoginPage path

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  bool isTermsAccepted = false;
  bool allFieldsValid = false;

  void _checkFormValidation() {
    final isValid = _nameCtrl.text.trim().isNotEmpty &&
        RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(_emailCtrl.text.trim()) &&
        _passwordCtrl.text.trim().length >= 6;

    setState(() {
      allFieldsValid = isValid;
      if (!isValid) isTermsAccepted = false; // reset if fields are invalid
    });
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.08,
            vertical: screenHeight * 0.03,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.04),
                Center(
                  child: Image.asset(
                    'assets/images/quizitt_mascot.png',
                    height: screenHeight * 0.12,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                const Text(
                  "Create an account",
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.04),

                // Name Field
                TextFormField(
                  controller: _nameCtrl,
                  decoration: const InputDecoration(
                    hintText: "Name",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => _checkFormValidation(),
                ),
                const SizedBox(height: 12),

                // Email Field
                TextFormField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (_) => _checkFormValidation(),
                ),
                const SizedBox(height: 12),

                // Password Field
                TextFormField(
                  controller: _passwordCtrl,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => _checkFormValidation(),
                ),
                const SizedBox(height: 12),

                // Checkbox only active if fields are valid
                Row(
                  children: [
                    Checkbox(
                      value: isTermsAccepted,
                      onChanged: allFieldsValid
                          ? (val) => setState(() => isTermsAccepted = val!)
                          : null,
                    ),
                    const Expanded(child: Text("Accept terms & conditions")),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),

                // Register Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: allFieldsValid && isTermsAccepted
                        ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Registration Successful')),
                      );
                      Future.delayed(const Duration(milliseconds: 500), () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      });
                    }
                        : null,
                    child: const Text("Register"),
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),
                const Text("or continue with", textAlign: TextAlign.center),
                SizedBox(height: screenHeight * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(Icons.facebook, size: 30),
                    Icon(Icons.g_mobiledata, size: 30),
                    Icon(Icons.apple, size: 30),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.purpleAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
