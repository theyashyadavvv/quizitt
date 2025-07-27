import 'package:flutter/material.dart';
import 'package:ecommerce/features/auth/presentation/pages/referral_page.dart';
import '../widgets/option_button.dart';

class TimePage extends StatelessWidget {
  const TimePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> options = [
      {'text': '30m–1hr', 'emoji': '🤔'},
      {'text': '1hr–3hr\'s', 'emoji': '😯'},
      {'text': '3hr–5hrs', 'emoji': '😌'},
      {'text': '>5hrs', 'emoji': '😊'},
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              questionHeader("How much Time can you dedicate daily?"),
              const SizedBox(height: 20),
              ...options.map(
                    (opt) => OptionButton(
                  title: opt['text']!,
                  emoji: opt['emoji'], // handled as nullable
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ReferralPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget questionHeader(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.purple, Colors.deepPurple],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
