import 'package:flutter/material.dart';
import '../widgets/option_button.dart';
import 'knowledge_page.dart';

class ReferralPage extends StatelessWidget {
  const ReferralPage({super.key});

  @override
  Widget build(BuildContext context) {
    final options = [
      {'text': 'T.V', 'icon': Icons.tv},
      {'text': 'Google Search', 'icon': Icons.search},
      {'text': 'YouTube', 'icon': Icons.play_circle_fill},
      {'text': 'News Article', 'icon': Icons.article},
      {'text': 'Peer\'s', 'icon': Icons.group},
      {'text': 'Social Media', 'icon': Icons.facebook},
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _questionHeader("How Did You Hear About Quizitt?"),
              const SizedBox(height: 20),
              ...options.map(
                    (opt) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: OptionButton(
                    title: opt['text'] as String,
                    icon: opt['icon'] as IconData,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const KnowledgePage(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _questionHeader(String text) {
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
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
