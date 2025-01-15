import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trinetra_vallabh/UI/screens/profile/profile_screen.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? rightImagePath;
  final String appBarColor;

  const CustomAppbar(
      {super.key, this.rightImagePath, this.appBarColor = 'Purple'});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor =
        appBarColor == 'white' ? Color(0xff4F378A) : Colors.white;
    return AppBar(
      leadingWidth: 36,
      backgroundColor: backgroundColor,
      leading: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SizedBox(
            width: 19,
            height: 25,
            child: FittedBox(
              fit: BoxFit.contain,
              child: appBarColor == 'white'
                  ? SvgPicture.asset('images/appbar-logo-white.svg')
                  : SvgPicture.asset('images/appbar-logo-purple.svg'),
            ),
          ),
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
