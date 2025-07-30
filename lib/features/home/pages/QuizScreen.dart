import 'package:flutter/material.dart';

import 'ResultScreen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Question> questions = [
    Question(
      text: 'Which of the following best describes Newton’s First Law of Motion?',
      options: [
        'Force is equal to mass times acceleration',
        'For every action, there is an equal and opposite reaction',
        'An object at rest or in motion stays that way unless acted upon',
        'Energy cannot be created or destroyed',
      ],
      correctIndex: 2,
    ),
    Question(
      text: 'An object continues to remain at rest or in uniform motion unless acted upon by an external force. This statement is known as Newton\'s ________.',
      options: ['First', 'Second', 'Third', 'None'],
      correctIndex: 0,
    ),
    Question(
      text: 'An object in motion will slow down if acted on by any force in the direction of motion.',
      options: ['True', 'False'],
      correctIndex: 0,
    ),
  ];

  final Map<int, int> selectedAnswers = {}; // questionIndex: selectedOptionIndex

  void selectAnswer(int questionIndex, int selectedIndex) {
    setState(() {
      selectedAnswers[questionIndex] = selectedIndex;
    });
  }

  void nextPage() {
    if (currentIndex < questions.length - 1) {
      setState(() => currentIndex++);
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void prevPage() {
    if (currentIndex > 0) {
      setState(() => currentIndex--);
      _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void submitQuiz() {
    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == questions[i].correctIndex) {
        score++;
      }
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(score: score, total: questions.length),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLast = currentIndex == questions.length - 1;

    return Scaffold(
      backgroundColor: const Color(0xFF1C2031),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C2031),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: LinearProgressIndicator(
                value: (currentIndex + 1) / questions.length,
                backgroundColor: Colors.grey[700],
                color: Colors.greenAccent,
              ),
            ),
            const SizedBox(height: 12),

            // Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Module-1 Section-1\nNewton\'s Law of Motion',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: QuizCard(
                      question: question,
                      selectedIndex: selectedAnswers[index],
                      onSelect: (value) => selectAnswer(index, value),
                    ),
                  );
                },
              ),
            ),

            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: prevPage,
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                  isLast
                      ? ElevatedButton(
                    onPressed: submitQuiz,
                    child: const Text("Submit"),
                  )
                      : IconButton(
                    onPressed: nextPage,
                    icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Model
class Question {
  final String text;
  final List<String> options;
  final int correctIndex;

  Question({
    required this.text,
    required this.options,
    required this.correctIndex,
  });
}

// Quiz Card
class QuizCard extends StatelessWidget {
  final Question question;
  final int? selectedIndex;
  final ValueChanged<int> onSelect;

  const QuizCard({
    super.key,
    required this.question,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF252A41),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.text,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 16),
          ...List.generate(question.options.length, (index) {
            final isSelected = selectedIndex == index;
            return GestureDetector(
              onTap: () => onSelect(index),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.greenAccent.withOpacity(0.2) : const Color(0xFF3C4255),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected ? Colors.greenAccent : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Text(
                  question.options[index],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
