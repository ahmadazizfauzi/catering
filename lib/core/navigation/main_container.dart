import 'package:catering_1/core/shared/drawer/app_drawer.dart';
import 'package:catering_1/features/contact/presentation/pages/contact_screen.dart';
import 'package:catering_1/features/home/presentation/pages/admin_home_screen.dart';
import 'package:catering_1/features/home/presentation/pages/consumen_home_screen.dart';
import 'package:catering_1/features/menu/presentation/pages/menu_screen.dart';
import 'package:catering_1/features/profile/presentation/provider/profile_provider.dart';
import 'package:catering_1/features/subscription/presentation/pages/user/subscription_screen.dart';
import 'package:catering_1/features/profile/presentation/pages/profile_screen.dart';
import 'package:catering_1/features/subscription/presentation/pages/user/user_subscription_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().fetchProfile();
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
    final profileProvider = Provider.of<ProfileProvider>(context, listen: true);
    final role = profileProvider.profile?.role ?? 'consumen';

    switch (_selectedIndex) {
      case 0:
        if (role == 'admin') {
          return AdminHomeScreen(
            onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
          );
        } else {
          return ConsumenHomeScreen(
            onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
          );
        }
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
      case 4:
        return ProfileScreen(
          onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
        );
      case 5:
        return UserSubscriptionScreen(
          onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
        );
      default:
        if (role == 'admin') {
          return AdminHomeScreen(
            onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
          );
        } else {
          return ConsumenHomeScreen(
            onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
          );
        }
    }
  }
}
