// ignore_for_file: deprecated_member_use, use_build_context_synchronously, avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trinetra_vallabh/UI/screens/details/lifestyledetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../../utils/user_auth_provider.dart';

class PersonalDetailsPage extends StatefulWidget {
  const PersonalDetailsPage({super.key});

  @override
  State<PersonalDetailsPage> createState() => _PersonalDetailsPageState();
}

enum Genders { male, female, other }

enum Address { home, office, other }

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  Set<Genders> selectionGender = <Genders>{Genders.male};

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final doorNumberController = TextEditingController();
  final apartmentController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final landmarkController = TextEditingController();
  final pincodeController = TextEditingController();

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
    final personalDetails = {
      'name': nameController.text,
      'age': int.parse(ageController.text),
      'email': emailController.text,
      'gender': selectionGender.first.name,
      'doorNumber': doorNumberController.text,
      'apartment': apartmentController.text,
      'city': cityController.text,
      'state': stateController.text,
      'landmark': landmarkController.text,
      'pincode': pincodeController.text,
    };

    final String uid = user.uid;
    try {
      await _firestore.collection('users').doc(uid).set({
        'isProfileCompleted' : false,
        'details': FieldValue.arrayUnion([
          {'personal': personalDetails}
        ])
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Data Saved"),
        duration: Duration(seconds: 2),
      ));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LifestyleDetailsPge(),
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
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    nameController.dispose();
    ageController.dispose();
    emailController.dispose();
    super.dispose();
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
                  child: userPhotoURL != null
                      ? SizedBox(
                          width: 80,
                          height: 80,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(userPhotoURL),
                          ),
                        )
                      : Image.asset(
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
                              controller: nameController,
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
                              controller: ageController,
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
                        controller: emailController,
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
                              controller: doorNumberController,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Apartment'),
                              controller: apartmentController,
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
                              controller: cityController,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'State'),
                              controller: stateController,
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
                              controller: landmarkController,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Pincode'),
                              controller: pincodeController,
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
          _saveData();
        },
        child: Icon(Icons.arrow_right_alt),
      ),
    );
  }
}
