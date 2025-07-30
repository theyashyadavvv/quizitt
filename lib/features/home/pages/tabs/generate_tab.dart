import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class GenerateQuizScreen extends StatefulWidget {
  const GenerateQuizScreen({super.key});

  @override
  State<GenerateQuizScreen> createState() => _GenerateQuizScreenState();
}

class _GenerateQuizScreenState extends State<GenerateQuizScreen> {
  bool _isLoading = false;
  File? _selectedFile;
  String? _selectedDifficulty;
  final List<String> _difficulties = ['Beginner', 'Medium', 'Hard'];
  final TextEditingController _promptController = TextEditingController();
  int _selectedTab = 0; // 0: Upload file, 1: Custom Prompt

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'pptx', 'jpg', 'jpeg'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _isLoading = true;
      });

      // Simulate loading delay
      await Future.delayed(const Duration(seconds: 3));

      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C163D),
      body: SafeArea(
        child: _isLoading
            ? _buildLoadingUI()
            : (_selectedTab == 0 ? _buildUploadUI() : _buildPromptUI()),
      ),
    );
  }

  Widget _buildUploadUI() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/quizitt_mascot.png', height: 60),
          const SizedBox(height: 12),
          const Text("Generate Quiz from PDF",
              style: TextStyle(
                  color: Colors.pinkAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text("Upload PDF and Generate Quizzes using AI",
              style: TextStyle(color: Colors.blueAccent, fontSize: 12)),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedTab = 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _selectedTab == 0
                          ? const Color(0xFFB5A8FB)
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Center(
                      child: Text("Upload file",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedTab = 1),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _selectedTab == 1
                          ? const Color(0xFFB5A8FB)
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Center(
                      child: Text("Custom Prompt",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () => setState(() => _selectedTab = 1),
            child: Container(
              padding: const EdgeInsets.all(14),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Enter Your Custom Prompt ✏️",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                  SizedBox(height: 4),
                  Text(
                      "Your Instructions to AI about what type of questions to generate",
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _pickFile,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2B4F),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white38, width: 1.2),
              ),
              child: Column(
                children: [
                  Image.asset('assets/images/pdf.png', height: 50),
                  const SizedBox(height: 10),
                  const Text("Click to Upload or Drag & Drop",
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                  const SizedBox(height: 4),
                  const Text("PDF, DOCX, PPTX, JPG, JPEG\nUpto 20 MB",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white54, fontSize: 12)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          ElevatedButton(
            onPressed: _pickFile,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD379E9),
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 3,
            ),
            child: const Text("Choose File",
                style: TextStyle(color: Colors.white, fontSize: 14)),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF5E60CE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: const Color(0xFF5E60CE),
                style: const TextStyle(color: Colors.white),
                hint: const Text("Select language",
                    style: TextStyle(color: Colors.white)),
                value: _selectedDifficulty,
                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                items: _difficulties.map((level) {
                  return DropdownMenuItem(
                      value: level,
                      child: Text(level, style: const TextStyle(color: Colors.white)));
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedDifficulty = value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromptUI() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/quizitt_mascot.png', height: 60),
          const SizedBox(height: 12),
          const Text("Generate Quiz from PDF",
              style: TextStyle(
                  color: Colors.pinkAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text("Upload PDF and Generate Quizzes using AI",
              style: TextStyle(color: Colors.blueAccent, fontSize: 12)),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedTab = 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _selectedTab == 0
                          ? const Color(0xFFB5A8FB)
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Center(
                      child: Text("Upload file",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedTab = 1),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _selectedTab == 1
                          ? const Color(0xFFB5A8FB)
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Center(
                      child: Text("Custom Prompt",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(14),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 4),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Type Or Paste your content here ✏️",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                const SizedBox(height: 4),
                TextField(
                  controller: _promptController,
                  maxLines: 4,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: "Your Instructions to AI about what type of questions to generate",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle prompt submission here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD379E9),
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 3,
            ),
            child: const Text("Generate Quiz",
                style: TextStyle(color: Colors.white, fontSize: 14)),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/quizitt_mascot.png', height: 60),
          const SizedBox(height: 20),
          const Text("Generate Quiz from PDF",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pinkAccent)),
          const Text("Upload PDF and Generate Quizzes using AI",
              style: TextStyle(color: Colors.blueAccent)),
          const SizedBox(height: 40),
          Image.asset('assets/images/loding.png', height: 120), // loading animation
          const SizedBox(height: 20),
          const Text("Please Wait While Your Quiz is being Generated...",
              style: TextStyle(color: Colors.white)),
          const SizedBox(height: 10),
          const LinearProgressIndicator(
            minHeight: 8,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
            backgroundColor: Colors.white24,
          ),
        ],
      ),
    );
  }
}

