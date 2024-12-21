// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:trinetra_vallabh/UI/components/custom_appbar.dart';

class Healthrecords extends StatefulWidget {
  const Healthrecords({super.key});

  @override
  State<Healthrecords> createState() => _HealthrecordsState();
}

class _HealthrecordsState extends State<Healthrecords> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        rightImagePath: 'images/non-user.png',
      ),
      body: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 80),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Section Three',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.black.withOpacity(0.5))),
              SizedBox(height: 10),
              Text('Your Health Records',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Color(0xff250F5E), fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              Text(
                  'This will allow us draft better health goals and time table for you',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w500)),
              SizedBox(height: 40),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Weight',
                              )),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Height',
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Water Percentage',
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                            child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Muscle Mass',
                          ),
                        ))
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                            child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Fat Percentage',
                          ),
                        )),
                        SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Bone Mass',
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Calories',
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ScheduleDataPage(),
          //   ),
          // );
        },
        child: Icon(Icons.arrow_right_alt),
      ),
    );
  }
}
