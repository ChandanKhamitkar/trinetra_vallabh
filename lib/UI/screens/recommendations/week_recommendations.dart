import 'package:flutter/material.dart';
import 'package:trinetra_vallabh/UI/components/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:trinetra_vallabh/UI/components/calendar/week_calendar.dart';
import 'package:trinetra_vallabh/UI/components/custom_appbar.dart';
import '../../../utils/user_auth_provider.dart';
import 'package:provider/provider.dart';

class WeekRecommendations extends StatefulWidget {
  const WeekRecommendations({super.key});

  @override
  State<WeekRecommendations> createState() => _WeekRecommendationsState();
}

class _WeekRecommendationsState extends State<WeekRecommendations> {
  @override
  Widget build(BuildContext context) {
    final userAuthProvider = Provider.of<UserAuthProvider>(context);
    final user = userAuthProvider.user;

    String? userPhotoURL;
    if (user != null) {
      userPhotoURL = user.photoURL;
    }
    return Scaffold(
      backgroundColor: Color(0xff4F378A),
      appBar: CustomAppbar(
        rightImagePath: userPhotoURL ?? 'images/non-user.png',
        appBarColor: 'white',
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: 20,
                bottom: 20,
              ),
              child: Text.rich(
                textAlign: TextAlign.left,
                TextSpan(
                  text: 'You have 6',
                  children: [
                    TextSpan(text: 'week\nplan'),
                    TextSpan(text: ' waiting for you!'),
                  ],
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffF5F5F5),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WeekCalendar(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
