import 'package:catering_1/features/about/presentation/pages/about_screen.dart';
import 'package:catering_1/features/menu/presentation/pages/menu_screen.dart';
import 'package:catering_1/features/subscription/presentation/pages/subscription_screen.dart';
import 'package:flutter/material.dart';
import 'package:catering_1/features/home/presentation/pages/home_screen.dart';
import 'package:catering_1/core/navigation/bottom_bar.dart';

class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    MenuScreen(),
    SubscriptionScreen(),
    // ContactScreen(),
    AboutScreen()
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}