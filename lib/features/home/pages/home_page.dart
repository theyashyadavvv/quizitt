import 'package:ecommerce/features/home/pages/tabs/generate_tab.dart';
import 'package:ecommerce/features/home/pages/tabs/login_tab.dart';
import 'package:ecommerce/features/home/pages/tabs/material_tab.dart';
import 'package:ecommerce/features/home/pages/tabs/Profile/profile_tab.dart';
import 'package:ecommerce/features/home/pages/tabs/quizzybot_tab.dart';
import 'package:ecommerce/features/home/pages/tabs/shop_tab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    LoginTab(),
    ShopTab(),
    GenerateTab(),
    MaterialTab(),
    QuizzyBotTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C1B33),
      body: Column(
        children: [
          Expanded(child: _pages[_selectedIndex]),

          // Divider line
          Container(
            height: 1,
            color: Colors.grey.shade700,
          ),

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
                icon: Image.asset(
                  'assets/icons/login.png',
                  width: 32,
                  height: 32,
                ),
                label: 'Login',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/generate.png',
                  width: 32,
                  height: 32,
                ),
                label: 'Generate',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/material.png',
                  width: 32,
                  height: 32,
                ),
                label: 'Material',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/shop.png',
                  width: 32,
                  height: 32,
                ),
                label: 'Shop',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/quizzybot.png',
                  width: 32,
                  height: 32,
                ),
                label: 'QuizzyBot',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/profile.png',
                  width: 32,
                  height: 32,
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
