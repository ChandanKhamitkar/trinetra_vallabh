// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
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
        "day": "Monday",
        "protien": "40g",
        "carbs": "40g",
        "fat": "15g",
      },
      {
        "meal": "Salmon with Roasted Broccoli and Sweet Potato",
        "day": "Tuesday",
        "protien": "35g",
        "carbs": "45g",
        "fat": "20g",
      },
      {
        "meal": "Turkey Meatloaf with Mashed Sweet Potatoes",
        "day": "Wednesday",
        "protien": "35g",
        "carbs": "45g",
        "fat": "18g",
      },
      {
        "meal": "Chicken Stir-fry with Brown Rice",
        "day": "Thursday",
        "protien": "35g",
        "carbs": "45g",
        "fat": "18g",
      },
      {
        "meal": "Tuna Salad Sandwich on Whole Wheat Bread",
        "day": "Friday",
        "protien": "35g",
        "carbs": "45g",
        "fat": "18g",
      },
      {
        "meal": "Lean Beef and Vegetable Skewers",
        "day": "Friday",
        "protien": "35g",
        "carbs": "45g",
        "fat": "18g",
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
              icon: const Icon(Icons.notifications_none),
              onPressed: () {},
            ),
            Text('Updates'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          Image.asset(
            'images/Ellipse-five.png',
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GOOD MORNING',
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
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(1.0),
                          fontSize: 20,
                        ),
                  )
                ]),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, bottom: 40.0, top: 200),
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
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(genData[index]["meal"],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: Colors.black.withOpacity(1.0),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900)),
                            ),
                            subtitle: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(genData[index]["day"],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    spacing: 6,
                                    children: [
                                      Expanded(
                                        child: Chip(
                                          avatar: Icon(Icons.fireplace_sharp),
                                          label:
                                              Text(genData[index]["protien"]),
                                        ),
                                      ),
                                      Expanded(
                                        child: Chip(
                                          avatar: Icon(Icons.grass_rounded),
                                          label: Text(genData[index]["carbs"]),
                                        ),
                                      ),
                                      Expanded(
                                        child: Chip(
                                          avatar:
                                              Icon(Icons.water_drop_outlined),
                                          label: Text(genData[index]["fat"]),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
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
