import 'package:flutter/material.dart';

class MaterialTab extends StatelessWidget {
  const MaterialTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2340),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Materials",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: <Color>[Colors.blue, Colors.purple],
                    ).createShader(
                        const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SubjectScreen(exam: "JEE"),
                    ),
                  );
                },
                child: buildMaterialCard(
                  title: "Joint Entrance Exam",
                  description:
                      "Master India’s Toughest Engineering Entrance exam with new age learning",
                  imagePath: "assets/images/material.png",
                  examShort: "JEE",
                  subjects: "PCM",
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SubjectScreen(exam: "NEET"),
                    ),
                  );
                },
                child: buildMaterialCard(
                  title: "National Eligibility Entrance Test",
                  description:
                      "Master India’s Toughest Medical Entrance exam with new age learning",
                  imagePath: "assets/images/material.png",
                  examShort: "NEET",
                  subjects: "PCB",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMaterialCard({
    required String title,
    required String description,
    required String imagePath,
    required String examShort,
    required String subjects,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2D365C),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue, width: 2),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(imagePath, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                examShort,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 6),
                Text(description,
                    style:
                        const TextStyle(fontSize: 12, color: Colors.white70)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.people, color: Colors.blue, size: 18),
                    const SizedBox(width: 6),
                    const Text("17", style: TextStyle(color: Colors.white)),
                    const Spacer(),
                    Row(
                      children: subjects
                          .split("")
                          .map((s) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: Text(
                                  s,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: s == "P"
                                        ? Colors.red
                                        : s == "C"
                                            ? Colors.green
                                            : Colors.orange,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SubjectScreen extends StatelessWidget {
  final String exam;
  const SubjectScreen({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> subjects = exam == "NEET"
        ? [
            {"title": "Biology", "image": "assets/images/dna.png"},
            {"title": "Chemistry", "image": "assets/images/chem.png"},
            {"title": "Physics", "image": "assets/images/phy.png"},
            {"title": "PYQ's", "image": "assets/images/pyq.png"},
          ]
        : [
            {"title": "Maths", "image": "assets/images/maths.png"},
            {"title": "Chemistry", "image": "assets/images/chem.png"},
            {"title": "Physics", "image": "assets/images/phy.png"},
            {"title": "PYQ's", "image": "assets/images/pyq.png"},
          ];

    return Scaffold(
      backgroundColor: const Color(0xFF1C2340),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C2340),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Materials",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: subjects.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 16, crossAxisSpacing: 16),
        itemBuilder: (context, index) {
          final subject = subjects[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      SubmoduleScreen(subjectName: subject["title"]),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blueAccent, width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Image.asset(subject["image"], width: 40),
                  ),
                  const SizedBox(height: 10),
                  Text(subject["title"],
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SubmoduleScreen extends StatelessWidget {
  final String subjectName;
  const SubmoduleScreen({super.key, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> modules = [
      {
        "module": "Module 1.1",
        "subs": [
          {
            "title": "Submodule Name",
            "desc":
                "Master maths for India's Toughest Engineering Entrance with New-Age Learning.",
            "pdf": "assets/pdfs/sample1.pdf"
          },
          {
            "title": "Submodule Name",
            "desc":
                "Master maths for India's Toughest Engineering Entrance with New-Age Learning.",
            "pdf": "assets/pdfs/sample2.pdf"
          },
        ]
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF1C2340),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C2340),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(subjectName,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: modules.length,
        itemBuilder: (context, index) {
          final module = modules[index];
          return Column(
            children: [
              Row(
                children: [
                  const Expanded(
                      child: Divider(color: Colors.white54, thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_left, color: Colors.white70),
                        Text(
                          module["module"],
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const Icon(Icons.arrow_right, color: Colors.white70),
                      ],
                    ),
                  ),
                  const Expanded(
                      child: Divider(color: Colors.white54, thickness: 1)),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: module["subs"].length,
                  itemBuilder: (context, subIndex) {
                    final sub = module["subs"][subIndex];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PDFViewerScreen(
                                title: sub["title"], pdfPath: sub["pdf"]),
                          ),
                        );
                      },
                      child: Container(
                        width: 180,
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: const DecorationImage(
                            image: AssetImage(
                                "assets/icons/backgroundblrur.png"),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(color: Colors.blueAccent, width: 2),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            const CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.add, color: Colors.black),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              "1.1.1 Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.grey),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              sub["title"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.blue),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                sub["desc"],
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black87),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PDFViewerScreen(
                                        title: sub["title"],
                                        pdfPath: sub["pdf"]),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    "assets/icons/pdficon.png",
                                    width: 24,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }
}

class PDFViewerScreen extends StatelessWidget {
  final String title;
  final String pdfPath;
  const PDFViewerScreen({super.key, required this.title, required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          "Here you can display PDF: $pdfPath",
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
