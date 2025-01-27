// ignore_for_file: deprecated_member_use, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:trinetra_vallabh/UI/components/custom_appbar.dart';
import 'package:trinetra_vallabh/UI/screens/details/foodpreferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/user_auth_provider.dart';
import 'package:provider/provider.dart';

class Healthrecords extends StatefulWidget {
  const Healthrecords({super.key});

  @override
  State<Healthrecords> createState() => _HealthrecordsState();
}

class _HealthrecordsState extends State<Healthrecords> {
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final waterPercentController = TextEditingController();
  final muscleMassController = TextEditingController();
  final fatPercentController = TextEditingController();
  final boneMassController = TextEditingController();
  final caloriesController = TextEditingController();

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

    if (weightController.text.isEmpty || heightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Weight and Height are mandatory!"),
        duration: Duration(seconds: 4),
      ));

      return;
    }

    final healthRecordDetails = {
      'weight': int.tryParse(weightController.text),
      'height': int.tryParse(heightController.text),
      'waterPercent': int.tryParse(waterPercentController.text),
      'muscleMass': int.tryParse(muscleMassController.text),
      'fatPercent': int.tryParse(fatPercentController.text),
      'boneMass': int.tryParse(boneMassController.text),
      'calories': int.tryParse(caloriesController.text)
    };

    final String uid = user.uid;
    try {
      await _firestore.collection('users').doc(uid).set({
        'details': FieldValue.arrayUnion([
          {'healthRecords': healthRecordDetails}
        ])
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Data Saved"),
        duration: Duration(seconds: 2),
      ));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FoodPreferences(),
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
                                suffixText: 'kg',
                                prefixIcon: Icon(Icons.monitor_weight_outlined),
                              ),
                              controller: weightController),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Height ',
                              suffixText: 'cm',
                              prefixIcon: Icon(Icons.height_rounded),
                            ),
                            controller: heightController,
                          ),
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
                              suffixText: '%',
                              prefixIcon: Icon(Icons.opacity),
                            ),
                            controller: waterPercentController,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                            child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Muscle Mass',
                            suffixText: 'kg',
                            prefixIcon: Icon(Icons.fitness_center_rounded),
                          ),
                          controller: muscleMassController,
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
                            suffixText: '%',
                            prefixIcon: Icon(Icons.local_pizza),
                          ),
                          controller: fatPercentController,
                        )),
                        SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Bone Mass',
                              suffixText: 'g/cm²',
                              prefixIcon: Icon(Icons.accessibility),
                            ),
                            controller: boneMassController,
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
                              suffixText: 'kcal',
                              prefixIcon: Icon(Icons.whatshot),
                            ),
                            controller: caloriesController,
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
          _saveData();
        },
        child: Icon(Icons.arrow_right_alt),
      ),
    );
  }
}
