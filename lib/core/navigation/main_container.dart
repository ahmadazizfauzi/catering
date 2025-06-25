import 'package:catering_1/core/shared/drawer/app_drawer.dart';
import 'package:catering_1/features/contact/presentation/pages/contact_screen.dart';
import 'package:catering_1/features/home/presentation/pages/home_screen.dart';
import 'package:catering_1/features/menu/presentation/pages/menu_screen.dart';
import 'package:catering_1/features/subscription/presentation/pages/subscription_screen.dart';
import 'package:flutter/material.dart';

class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemSelected,
      ),
      body: _buildScreen(),
    );
  }

  Widget _buildScreen() {
    switch (_selectedIndex) {
      case 0:
        return HomeScreen(
          onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
        );
      case 1:
        return MenuScreen(
          onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
        );
      case 2:
        return SubscriptionScreen(
          onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
        );
      case 3:
        return ContactScreen(
          onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
        );
      default:
        return HomeScreen(
          onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
        );
    }
  }
}