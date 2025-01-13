// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:trinetra_vallabh/UI/components/custom_appbar.dart';
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
      ),
      bottomNavigationBar: BottomAppBar(
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
                setState(() {});
              },
            ),
            Text('Saved'),
            IconButton(
              icon: const Icon(Icons.person_2_outlined),
              onPressed: () {},
            ),
            Text('Profile'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'images/Ellipse-six.png',
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 110,
                    height: 110,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(userPhotoURL!),
                      radius: 55,
                      backgroundColor: Colors.grey 
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 10,
                      children: [
                        Text(
                          user!.displayName ?? 'Guest',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
