import 'package:flutter/material.dart';
import 'package:trinetra_vallabh/UI/screens/profile/profile_screen.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavigationItem(context, Icons.location_on, 'Explore', () {}),
          _buildNavigationItem(context, Icons.bookmark_border, 'Saved', () {}),
          _buildNavigationItem(context, Icons.person_2_outlined, 'Profile', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildNavigationItem(
      BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return IconButton(
      autofocus: true,
      onPressed: onTap,
      icon: Column(
        // Wrap icon and label in a Column
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}
