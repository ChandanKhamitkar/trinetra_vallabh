// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:trinetra_vallabh/UI/components/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:trinetra_vallabh/UI/components/custom_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      // {
      //   "meal": "Grilled Chicken Salad with Quinoa",
      //   "day": "EASY TO COOK | 10min",
      //   "protien": "12cal",
      //   "carbs": "30gm",
      //   "fat": "15gm",
      //   "cys": "30gm",
      // },
      // {
      //   "meal": "Grilled Chicken Salad with Quinoa",
      //   "day": "EASY TO COOK | 10min",
      //   "protien": "12cal",
      //   "carbs": "30gm",
      //   "fat": "15gm",
      //   "cys": "30gm",
      // },
      // {
      //   "meal": "Grilled Chicken Salad with Quinoa",
      //   "day": "EASY TO COOK | 10min",
      //   "protien": "12cal",
      //   "carbs": "30gm",
      //   "fat": "15gm",
      //   "cys": "30gm",
      // },
      // {
      //   "meal": "Grilled Chicken Salad with Quinoa",
      //   "day": "EASY TO COOK | 10min",
      //   "protien": "12cal",
      //   "carbs": "30gm",
      //   "fat": "15gm",
      //   "cys": "30gm",
      // },
      // {
      //   "meal": "Grilled Chicken Salad with Quinoa",
      //   "day": "EASY TO COOK | 10min",
      //   "protien": "12cal",
      //   "carbs": "30gm",
      //   "fat": "15gm",
      //   "cys": "30gm",
      // },
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
              // width: double.infinity,
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
                        Card(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(
                                9.0), // Add padding to the card content
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 8,
                              children: [
                                Icon(
                                  Icons.brightness_5_outlined,
                                  color: Color(0xff65558F),
                                ), // Spacing between icon and content
                                Text(genData[index]["meal"],
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.w900)),
                                Text(genData[index]["day"],
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium),
                                Wrap(
                                  spacing: 12,
                                  children: [
                                    Chip(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      avatar: Icon(Icons.local_fire_department),
                                      label: Text(
                                        genData[index]["protien"],
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Chip(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      avatar: Icon(Icons.spa_outlined),
                                      label: Text(
                                        genData[index]["carbs"],
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Chip(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      avatar: Icon(Icons.water_drop_outlined),
                                      label: Text(
                                        genData[index]["fat"],
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Chip(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      avatar: Icon(Icons.flash_on_outlined),
                                      label: Text(
                                        genData[index]["cys"],
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
                                    onPressed: () {},
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
