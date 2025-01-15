// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:trinetra_vallabh/UI/components/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:trinetra_vallabh/UI/components/custom_appbar.dart';
import 'package:trinetra_vallabh/UI/screens/onboarding/login_page.dart';
import '../../../utils/user_auth_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userAuthProvider = Provider.of<UserAuthProvider>(context);
    final user = userAuthProvider.user;

    String? userPhotoURL;
    if (user != null) {
      userPhotoURL = user.photoURL;
    }
    return Scaffold(
      appBar: CustomAppbar(
        rightImagePath: userPhotoURL ?? 'images/non-user.png',
        appBarColor: 'white',
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              child: Image.asset(
                'images/Ellipse-six.png',
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                children: [
                  SizedBox(
                    width: 110,
                    height: 110,
                    child: CircleAvatar(
                        backgroundImage: NetworkImage(userPhotoURL!),
                        radius: 55,
                        backgroundColor: Colors.grey),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 10,
                      children: [
                        Text(
                          user!.displayName ?? 'Guest',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        Text(
                          user.email ?? 'Example@vallabh.com',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: Colors.white.withOpacity(0.7)),
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            await userAuthProvider.signOut();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.white,
                            weight: 400,
                          ),
                          label: const Text('Sign out'),
                          iconAlignment: IconAlignment.start,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
