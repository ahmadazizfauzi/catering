import 'package:catering_1/core/colors/app_colors.dart';
import 'package:catering_1/core/shared/appbar/appbar_shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/profile_provider.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback? onMenuPressed;

  const ProfileScreen({super.key, this.onMenuPressed});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().fetchProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();
    final profile = provider.profile;

    return Scaffold(
      backgroundColor: AppColors.brand['background'],
      appBar: AppbarShared(
        title: 'Setting',
        icon: const Icon(Icons.person, color: Colors.white),
        leading:
            widget.onMenuPressed != null
                ? IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: widget.onMenuPressed,
                )
                : null,
      ),
      body:
          provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : provider.message != null
              ? Center(child: Text(provider.message!))
              : Column(
                children: [
                  const SizedBox(height: 16),
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.grey[300],
                    backgroundImage:
                        profile?.photoUrl != null
                            ? NetworkImage(profile!.photoUrl!)
                            : null,
                    child:
                        profile?.photoUrl == null
                            ? const Icon(Icons.person, size: 45)
                            : null,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    profile?.name ?? '-',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.brand['text'],
                    ),
                  ),
                  Text(
                    profile?.email ?? '-',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.brand['text'],
                    ),
                  ),
                  const SizedBox(height: 30),
                  ListTile(
                    leading: const Icon(
                      Icons.restaurant_menu,
                      color: Colors.blue,
                    ),
                    title: const Text("Program Meal Saya"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Navigasi ke halaman meal program
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person, color: Colors.blue),
                    title: const Text("Profile Setting"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.key, color: Colors.blue),
                    title: const Text("Change Password"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                ],
              ),
    );
  }
}
