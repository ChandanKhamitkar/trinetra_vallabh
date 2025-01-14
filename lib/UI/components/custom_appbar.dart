import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trinetra_vallabh/UI/screens/profile/profile_screen.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? rightImagePath;

  const CustomAppbar({super.key, this.rightImagePath});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: SvgPicture.asset(
          'images/logo.svg',
          width: 25.7,
          height: 25.7,
          semanticsLabel: 'App bar',
        ),
      ),
      actions: [
        if (rightImagePath != null)
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
              child: rightImagePath!.startsWith('http')
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(rightImagePath!),
                    )
                  : Image.asset(
                      rightImagePath!,
                      width: 25.7,
                      height: 25.7,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
      ],
    );
  }
}
