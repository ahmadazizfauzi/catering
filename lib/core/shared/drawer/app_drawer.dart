import 'package:catering_1/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:catering_1/features/auth/presentation/provider/auth_provider.dart'
    as my_auth;
import 'package:catering_1/features/profile/presentation/provider/profile_provider.dart';

class AppDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const AppDrawer({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isNarrow = screenSize.width < 350;
    final profileProvider = Provider.of<ProfileProvider>(context, listen: true);
    final role = profileProvider.profile?.role ?? 'consumen';

    return Drawer(
      backgroundColor: AppColors.brand['light'],
      width: isNarrow ? 250 : 280,
      child: Column(
        children: [
          _buildUserProfile(context),
          const SizedBox(height: 20),
          _buildDrawerItem(
            context,
            icon: Icons.home,
            title: 'Beranda',
            index: 0,
          ),
          if (role != 'admin') ...[
            _buildDrawerItem(
              context,
              icon: Icons.restaurant_menu,
              title: 'Meal',
              index: 1,
            ),
            _buildDrawerItem(
              context,
              icon: Icons.receipt_long,
              title: 'Subscription',
              index: 2,
            ),
            _buildDrawerItem(
              context,
              icon: Icons.contact_mail,
              title: 'Contact Us',
              index: 3,
            ),
          ],
          _buildDrawerItem(
            context,
            icon: Icons.person,
            title: 'My Profile',
            index: 4,
          ),
          if (role != 'admin')
            _buildDrawerItem(
              context,
              icon: Icons.subscriptions,
              title: 'My Subscription',
              index: 5,
            ),
          _buildDrawerItem(
            context,
            icon: Icons.logout,
            title: 'Logout',
            index: 6,
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: true);
    final role = profileProvider.profile?.role ?? 'consumen';

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.black['default']!, width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Icon(
                Icons.person,
                size: 40,
                color: AppColors.black['default'],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Catering',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.black['default'],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            role == 'admin' ? 'Admin Portal' : 'User Portal',
            style: TextStyle(fontSize: 14, color: AppColors.black['default']),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required int index,
  }) {
    final isSelected = selectedIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: InkWell(
        onTap: () async {
          if (title == 'Logout') {
            await Navigator.of(context).maybePop();
            // ignore: use_build_context_synchronously
            await context.read<my_auth.AuthProvider>().logout();
            if (context.mounted) {
              Navigator.of(context).pushReplacementNamed('/login');
            }
          } else {
            onItemSelected(index);
            Navigator.pop(context);
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isSelected ? AppColors.brand['default'] : Colors.transparent,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 22,
                color:
                    isSelected
                        ? AppColors.white['default']
                        : AppColors.black['light'],
              ),
              const SizedBox(width: 18),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color:
                      isSelected
                          ? AppColors.white['default']
                          : AppColors.black['default'],
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
