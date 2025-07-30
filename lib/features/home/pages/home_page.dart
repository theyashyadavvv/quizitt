import 'tabs/generate_tab.dart';
import 'tabs/HomeTab.dart';
import 'tabs/material_tab.dart';
import 'tabs/Profile/profile_tab.dart';
import 'tabs/quizzybot_tab.dart';
import 'tabs/shop_tab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeTab(),
    GenerateQuizScreen(),
    const MaterialTab(),
    const ShopTab(),
    const QuizzyBotTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C1B33),
      body: Column(
        children: [
          Expanded(child: _pages[_selectedIndex]),

          // Bottom navigation bar
          BottomNavigationBar(
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white60,
            backgroundColor: const Color(0xFF0C1B33),
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() => _selectedIndex = index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Image.asset(
                      'assets/icons/login.png',
                      width: 32,
                      height: 32,
                    ),
                    if (_selectedIndex == 0)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        height: 4,
                        width: 24,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                  ],
                ),
                label: 'Login',
              ),
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Image.asset(
                      'assets/icons/generate.png',
                      width: 32,
                      height: 32,
                    ),
                    if (_selectedIndex == 1)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        height: 4,
                        width: 24,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                  ],
                ),
                label: 'Generate',
              ),
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Image.asset(
                      'assets/icons/material.png',
                      width: 32,
                      height: 32,
                    ),
                    if (_selectedIndex == 2)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        height: 4,
                        width: 24,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                  ],
                ),
                label: 'Material',
              ),
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Image.asset(
                      'assets/icons/shop.png',
                      width: 32,
                      height: 32,
                    ),
                    if (_selectedIndex == 3)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        height: 4,
                        width: 24,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                  ],
                ),
                label: 'Shop',
              ),
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Image.asset(
                      'assets/icons/quizzybot.png',
                      width: 32,
                      height: 32,
                    ),
                    if (_selectedIndex == 4)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        height: 4,
                        width: 24,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                  ],
                ),
                label: 'QuizzyBot',
              ),
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Image.asset(
                      'assets/icons/profile.png',
                      width: 32,
                      height: 32,
                    ),
                    if (_selectedIndex == 5)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        height: 4,
                        width: 24,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                  ],
                ),
                label: 'Profile',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
