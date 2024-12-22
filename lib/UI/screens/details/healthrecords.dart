// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:trinetra_vallabh/UI/components/custom_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trinetra_vallabh/UI/screens/details/foodpreferences.dart';

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

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('weight', weightController.text);
    await prefs.setInt('height', int.tryParse(heightController.text) ?? 0);
    await prefs.setString('waterPercent', waterPercentController.text);
    await prefs.setString('muscleMass', muscleMassController.text);
    await prefs.setString('fatPercent', fatPercentController.text);
    await prefs.setString('boneMass', boneMassController.text);
    await prefs.setString('calories', caloriesController.text);

    // You can add more fields here to save
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Data Saved"),
      duration: Duration(seconds: 5),
    ));
  }

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
                                labelText: 'Weight (kg)',
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
                              labelText: 'Height (cm)',
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FoodPreferences(),
            ),
          );
        },
        child: Icon(Icons.arrow_right_alt),
      ),
    );
  }
}
