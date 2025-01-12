// ignore_for_file: deprecated_member_use, use_build_context_synchronously, avoid_print
import 'package:flutter/material.dart';
import 'package:trinetra_vallabh/UI/components/custom_appbar.dart';
import 'package:trinetra_vallabh/UI/components/lifestyle_details/selectable_container.dart';
import 'package:trinetra_vallabh/UI/screens/details/scheduledetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/user_auth_provider.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class LifestyleDetailsPge extends StatefulWidget {
  const LifestyleDetailsPge({super.key});

  @override
  State<LifestyleDetailsPge> createState() => _LifestyleDetailsPgeState();
}

class _LifestyleDetailsPgeState extends State<LifestyleDetailsPge> {
  late List<Map<String, dynamic>> healthGoals;
  late List<Map<String, dynamic>> healthIssues;
  int selectedLifeStyleIndex = 0;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _saveData() async {
    final userAuthProvider =
        Provider.of<UserAuthProvider>(context, listen: false);
    final user = userAuthProvider.user;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User not logged in. Please login first!"),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final extractedLifeStyleIndex = selectedLifeStyleIndex == 0
        ? 'SEDENTARTY'
        : selectedLifeStyleIndex == 1
            ? 'ACTIVE'
            : selectedLifeStyleIndex == 2
                ? 'HECTIC'
                : '';
    final selectedHealthGoals = healthGoals
        .where((goal) => goal["isChecked"] == true)
        .map((goal) => goal["label"].toString())
        .toList();
    final selectedHealthIssues = healthIssues
        .where((issue) => issue["isChecked"] == true)
        .map((issue) => issue["label"].toString())
        .toList();

    final lifeStyleDetails = {
      'selectedLifestyle': extractedLifeStyleIndex,
      'healthGoals': selectedHealthGoals,
      'healthIssues': selectedHealthIssues
    };

    final String uid = user.uid;
    try {
      await _firestore.collection('users').doc(uid).set({
        'details': FieldValue.arrayUnion([
          {'lifestyle': lifeStyleDetails}
        ])
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Data Saved"),
        duration: Duration(seconds: 2),
      ));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScheduleDetailsPage(),
        ),
      );
    } catch (e) {
      print('Error in saving data! ');
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to save data to cloud!"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    healthGoals = [
      {
        "label": "Body Building",
        "isChecked": false,
      },
      {"label": "Immunity Boost", "isChecked": false},
      {"label": "Grow tall", "isChecked": false},
      {"label": "Gaining Weight", "isChecked": false},
      {"label": "Loosing Weight", "isChecked": false},
    ];
    healthIssues = [
      {"label": "Diabetes", "isChecked": false},
      {"label": "Thryoid", "isChecked": false},
      {"label": "Obesity", "isChecked": false},
      {"label": "Blood Pressure", "isChecked": false},
      {"label": "PCOS", "isChecked": false},
      {"label": "Vision impairment", "isChecked": false},
    ];
  }

  void _updateCheckboxHealthGoals(int index, bool? newValue) {
    setState(() {
      healthGoals[index]["isChecked"] = newValue ?? false;
    });
  }

  void _updateCheckboxHealthIssues(int index, bool? newValue) {
    setState(() {
      healthIssues[index]["isChecked"] = newValue ?? false;
    });
  }

  void _updateSelectedLifestyle(int index) {
    setState(() {
      selectedLifeStyleIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        rightImagePath: 'images/non-user.png',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 80),
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

              // -- Your LifeStyle
              Text(
                'Your Lifestyle',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SelectableContainer(
                            title: 'Sedentary',
                            imagePath: 'images/lifestyle-one.png',
                            index: 1,
                            isSelectedIndex: selectedLifeStyleIndex,
                            onTap: (index) {
                              _updateSelectedLifestyle(index);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: SelectableContainer(
                            title: 'Active',
                            imagePath: 'images/lifestyle-two.png',
                            index: 2,
                            isSelectedIndex: selectedLifeStyleIndex,
                            onTap: (index) {
                              _updateSelectedLifestyle(index);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SelectableContainer(
                      title: 'Hectic',
                      imagePath: 'images/lifestyle-three.png',
                      index: 3,
                      isSelectedIndex: selectedLifeStyleIndex,
                      onTap: (index) {
                        _updateSelectedLifestyle(index);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Your health Goals',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: healthGoals.length,
                itemBuilder: (context, index) {
                  return Align(
                    widthFactor: double.infinity,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              healthGoals[index]["label"],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: Color(0xff1D1B20),
                                  ),
                            ),
                            Spacer(),
                            Checkbox(
                              value: healthGoals[index]["isChecked"],
                              onChanged: (bool? value) {
                                setState(() {
                                  _updateCheckboxHealthGoals(index, value);
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        )
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Your health Issues',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: healthIssues.length,
                itemBuilder: (context, index) {
                  return Align(
                    widthFactor: double.infinity,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              healthIssues[index]["label"],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: Color(0xff1D1B20),
                                  ),
                            ),
                            Spacer(),
                            Checkbox(
                              value: healthIssues[index]["isChecked"],
                              onChanged: (bool? value) {
                                setState(() {
                                  _updateCheckboxHealthIssues(index, value);
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _saveData();
        },
        child: Icon(Icons.arrow_right_alt),
      ),
    );
  }
}
