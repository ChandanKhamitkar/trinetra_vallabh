import 'package:flutter/material.dart';
import 'package:trinetra_vallabh/UI/screens/profile/profile_screen.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () {},
          ),
          Text('Explore'),
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {
            },
          ),
          Text('Saved'),
          IconButton(
            icon: const Icon(Icons.person_2_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              );
            },
          ),
          Text('Profile'),
        ],
      ),
    );
  }
}
