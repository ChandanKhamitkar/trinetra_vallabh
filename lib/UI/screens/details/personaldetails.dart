// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trinetra_vallabh/UI/screens/details/lifestyledetails.dart';

class PersonalDetailsPage extends StatefulWidget {
  const PersonalDetailsPage({super.key});

  @override
  State<PersonalDetailsPage> createState() => _PersonalDetailsPageState();
}

enum Genders { male, female, other }

enum Address { home, office, other }

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  Set<Genders> selectionGender = <Genders>{Genders.male};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset('images/logo.svg', width: 25.7, height: 25.7),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'images/non-user.png',
                    width: 80,
                    height: 80,
                  ),
                ),
                SizedBox(height: 30),
                Text('Section One',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.black.withOpacity(0.5))),
                SizedBox(height: 10),
                Text('Your Personal Information',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Name'),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Age'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email Address'),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<Genders>(
                    segments: const <ButtonSegment<Genders>>[
                      ButtonSegment<Genders>(
                          value: Genders.male, label: Text('Male')),
                      ButtonSegment<Genders>(
                          value: Genders.female, label: Text('Female')),
                      ButtonSegment<Genders>(
                          value: Genders.other, label: Text('Other')),
                    ],
                    selected: selectionGender,
                    onSelectionChanged: (Set<Genders> newGenderSelection) {
                      setState(() {
                        selectionGender = newGenderSelection;
                      });
                    },
                    multiSelectionEnabled: false,
                  ),
                ),
                SizedBox(height: 30),
                Text('Your Address',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Color(0xff250F5E))),
                SizedBox(height: 10),
                Text(
                    'This will allow us draft a menu based on local delicacies and fresh veggies in and around you',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w500)),
                SizedBox(height: 10),
                Row(
                  children: [
                    FilterChip(
                        label: const Text('Home'),
                        onSelected: (_) {},
                        selected: true),
                    SizedBox(width: 10),
                    Chip(label: const Text('Office')),
                    SizedBox(width: 10),
                    Chip(label: const Text('Other')),
                  ],
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Door Number'),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Apartment'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'City'),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'State'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Landmark'),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Pincode'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LifestyleDetailsPge(),
            ),
          );
        },
        child: Icon(Icons.arrow_right_alt),
      ),
    );
  }
}
