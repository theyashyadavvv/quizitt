import 'package:ecommerce/features/auth/presentation/pages/onboarding_page.dart';
import 'package:flutter/material.dart';
import '../../../home/pages/home_page.dart';
import '../widgets/option_button.dart';

class KnowledgePage extends StatelessWidget {
  const KnowledgePage({super.key});

  @override
  Widget build(BuildContext context) {
    final levels = [
      'Beginner',
      'I Know Basics',
      'I\'m getting hang of it',
      'I have confidence in most topics',
      'I have mastered almost everything',
      'I\'m simply a PRO',
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              questionHeader("How much do you Know about J.E.E"),
              const SizedBox(height: 20),
              ...levels.map((level) => OptionButton(
                title: level,
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget questionHeader(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Colors.purple, Colors.deepPurple]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}
