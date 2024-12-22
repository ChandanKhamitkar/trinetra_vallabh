// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trinetra_vallabh/UI/components/custom_appbar.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        rightImagePath: 'images/non-user.png',
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
      body: Stack(children: [
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
            padding: const EdgeInsets.all(10.0),
            child: Card(
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Quinoa and Black Bean Burrito Bowls with Avocado Crema',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                      child: Text('EASY TO COOK | 10min',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Colors.black.withOpacity(0.7),
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
                              label: Text('data'),
                            ),
                          ),
                          Expanded(
                            child: Chip(
                              avatar: Icon(Icons.grass_rounded),
                              label: Text('data'),
                            ),
                          ),
                          Expanded(
                            child: Chip(
                              avatar: Icon(Icons.water_drop_outlined),
                              label: Text('data'),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
