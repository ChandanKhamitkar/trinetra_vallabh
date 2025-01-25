// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:trinetra_vallabh/UI/components/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:trinetra_vallabh/UI/components/cards/recipe/recipe_card_default.dart';
import 'package:trinetra_vallabh/UI/components/custom_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trinetra_vallabh/UI/screens/recommendations/week_recommendations.dart';
import '../../utils/user_auth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  late List<Map<String, dynamic>> genData;

  @override
  void initState() {
    super.initState();
    genData = [
      {
        "meal": "Grilled Chicken Salad with Quinoa",
        "day": "EASY TO COOK | 10min",
        "protien": "12cal",
        "carbs": "30gm",
        "fat": "15gm",
        "cys": "30gm",
      },
    ];
  }

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
        child: Stack(children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2,
            child: Image.asset(
              'images/Ellipse-five.png',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 0,
            right: 10,
            child: Image.asset(
              'images/av-three.png',
              width: 330,
              height: 440,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello!!',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white.withOpacity(0.5)),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Hi,Chandan!',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withOpacity(1.0),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Grr..... someone seems to be hungry now?',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.white.withOpacity(0.7),
                        ),
                  )
                ]),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, bottom: 40.0, top: 260),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: genData.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RecipeCardDefault(
                          title: "Grilled Chicken Salad with Quinoa",
                          day: "EASY TO COOK | 10min",
                          protein: "12cal",
                          carbs: "30gm",
                          calories: "300",
                          ingredients: [],
                          recipe: [],
                          cutlery: [],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Divider(color: Colors.grey),
                            Positioned(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xff65558F),
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.all(20),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              WeekRecommendations(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'View other recommendations',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(color: Colors.white),
                                    )))
                          ],
                        )
                      ],
                    );
                  }),
            ),
          )
        ]),
      ),
    );
  }
}
