// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:trinetra_vallabh/UI/components/custom_appbar.dart';
import 'package:trinetra_vallabh/UI/components/schedule_details/schedule_container.dart';

class ScheduleDetailsPage extends StatefulWidget {
  const ScheduleDetailsPage({super.key});

  @override
  State<ScheduleDetailsPage> createState() => _ScheduleDetailsPageState();
}

class _ScheduleDetailsPageState extends State<ScheduleDetailsPage> {
  late List<Map<String, dynamic>> scheduleData;

  @override
  void initState() {
    super.initState();
    scheduleData = [
      {
        "fromTime": "10:00 AM",
        "toTime": "10:20 AM",
        "duration": "(20 mins)",
        "title": "Getting Ready",
        "description":
            "Supporting line text lorem ipsum dolor sit amet, consectetur.",
      },
      {
        "fromTime": "10:00 AM",
        "toTime": "10:20 AM",
        "duration": "(20 mins)",
        "title": "Getting Ready",
        "description":
            "Supporting line text lorem ipsum dolor sit amet, consectetur.",
      },
      {
        "fromTime": "10:00 AM",
        "toTime": "10:20 AM",
        "duration": "(20 mins)",
        "title": "Getting Ready",
        "description":
            "Supporting line text lorem ipsum dolor sit amet, consectetur.",
      },
      {
        "fromTime": "10:00 AM",
        "toTime": "10:20 AM",
        "duration": "(20 mins)",
        "title": "Getting Ready",
        "description": "",
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppbar(
          rightImagePath: 'images/non-user.png',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: 80,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Section One',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.black.withOpacity(0.5))),
                SizedBox(height: 10),
                Text('Your Personal Performation',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Color(0xff250F5E), fontWeight: FontWeight.w600)),
                SizedBox(height: 10),
                Text(
                    'This will allow us draft better health goals and time table for you',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w500)),
                SizedBox(height: 40),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: scheduleData.length,
                  itemBuilder: (context, index) {
                    return ScheduleContainer(
                      fromTime: scheduleData[index]["fromTime"],
                      toTime: scheduleData[index]["toTime"],
                      duration: scheduleData[index]["duration"],
                      title: scheduleData[index]["title"],
                      description: scheduleData[index]["description"],
                    );
                  },
                )
              ],
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScheduleDetailsPage(),
                  ),
                );
              },
              label: Text('Add Item'),
              icon: Icon(Icons.arrow_right_alt),
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScheduleDetailsPage(),
                  ),
                );
              },
              child: Icon(Icons.arrow_right_alt),
            )
          ],
        ));
  }
}
