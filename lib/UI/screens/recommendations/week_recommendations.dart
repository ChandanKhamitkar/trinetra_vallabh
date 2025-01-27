// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:trinetra_vallabh/UI/components/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:trinetra_vallabh/UI/components/calendar/week_calendar.dart';
import 'package:trinetra_vallabh/UI/components/cards/recipe/recipe_card_default.dart';
import 'package:trinetra_vallabh/UI/components/custom_appbar.dart';
import '../../../utils/user_auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

class WeekRecommendations extends StatefulWidget {
  const WeekRecommendations({super.key});

  @override
  State<WeekRecommendations> createState() => _WeekRecommendationsState();
}

class _WeekRecommendationsState extends State<WeekRecommendations> {
  String? userUID;
  String? userPhotoURL;
  int selectedDay = DateTime.now().weekday - 1;
  late Map<String, dynamic> weekData;
  late Map<String, dynamic> selectedDayData = {};
  final List<String> daysLong = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thurday',
    'Friday',
    'Saturday'
  ];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedDay = DateTime.now().weekday - 1;
    });

    final userAuthProvider =
        Provider.of<UserAuthProvider>(context, listen: false);
    final user = userAuthProvider.user;

    if (user != null) {
      userUID = user.uid;
      userPhotoURL = user.photoURL;
    }

    fetchWholeWeeksData();
  }

  // We call GENKIT here
  Future<void> fetchWholeWeeksData() async {
    // Step-1 : Form weekrange string
    DateTime now = DateTime.now();
    int currentWeekDay = now.weekday;
    DateTime startOfWeek = now.subtract(Duration(days: currentWeekDay - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 5));

    String startOfWeekFormatted = DateFormat('dd-MM-yyyy').format(startOfWeek);
    String endOfWeekFormatted = DateFormat('dd-MM-yyyy').format(endOfWeek);

    String weekRangeString = '$startOfWeekFormatted-$endOfWeekFormatted';
    print(weekRangeString);

    // Check if data exists in the data base ??
    // if not exists then set call genkit and set data into firestore
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userUID).get();
      if (userDoc.exists && userDoc.get('genAISuggestion') != null) {
        if (userDoc.get('genAISuggestion').containsKey(weekRangeString)) {
          print('Complete week day is present in DB... 🔥 ');

          // Gets the docID
          String menuDocID = userDoc.get('genAISuggestion')[weekRangeString];

          // Retrive data from GenKitSuggestions Collection
          DocumentSnapshot menuDoc = await _firestore
              .collection('GenKitSuggestions')
              .doc(menuDocID)
              .get();

          Object? entireDocData = menuDoc.data();

          print('The actual doc data that has been got: $entireDocData');

          if (menuDoc.exists && menuDoc.get('menu') != null) {
            Map<String, dynamic> docDetails =
                menuDoc.get('menu') as Map<String, dynamic>;
            print('Menu Doc from DB = $docDetails');

            setState(() {
              weekData = docDetails;
            });
            _updateShowCaseData(selectedDay);
          } else {
            print("Error: menu field not found or is null in document");
          }
        } else {
          print('❌ week day is not present in DB... 🔥 ');
          List<dynamic> userDocDetailsData = userDoc.get('details');

          Map<String, dynamic>? personalDetailsData = userDocDetailsData
              .firstWhere((item) => item.containsKey('personal'),
                  orElse: () => {})['personal'];
          Map<String, dynamic>? lifestyleDetailsData = userDocDetailsData
              .firstWhere((item) => item.containsKey('lifestyle'),
                  orElse: () => {})['lifestyle'];
          Map<String, dynamic>? healthRecordsDetailsData = userDocDetailsData
              .firstWhere((item) => item.containsKey('healthRecords'),
                  orElse: () => {})['healthRecords'];
          Map<String, dynamic>? foodPreferencesDetailsData = userDocDetailsData
              .firstWhere((item) => item.containsKey('foodPreferences'),
                  orElse: () => {})['foodPreferences'];
          Map<String, dynamic>? allergiesDetailsData = userDocDetailsData
              .firstWhere((item) => item.containsKey('alergic'),
                  orElse: () => {})['alergic'];

          Map<String, dynamic> genkitJson = {
            'name': personalDetailsData?['name'],
            'gender': personalDetailsData?['gender'],
            'age': personalDetailsData?['age'],
            'lifestyle': lifestyleDetailsData?['selectedLifestyle'],
            'healthGoals': lifestyleDetailsData?['healthGoals'],
            'healthIssues': lifestyleDetailsData?['healthIssues'],
            'healthRecords': healthRecordsDetailsData,
            'foodPreferences': foodPreferencesDetailsData,
            'allergies': allergiesDetailsData?['allergies'],
            'favouriteFoods': allergiesDetailsData?['favouriteFoods'],
          };
          print('genkitJson: $genkitJson');

          // Call the Genkit
          try {
            final callable =
                FirebaseFunctions.instance.httpsCallable('menuSuggestionFlow');

            final results = await callable.call(genkitJson);

            final data = results.data;

            if (data != null) {
              print('Response from cloud function: $data');
              Map<String, dynamic> wholeData = data;
              try {
                var newDoc = await _firestore
                    .collection('GenKitSuggestions')
                    .add(wholeData);
                print('new doc is = $newDoc');
                var docId = newDoc.id;
                print('new doc is = $docId');
                await _firestore.collection('users').doc(userUID).set({
                  'genAISuggestion': {weekRangeString: docId}
                }, SetOptions(merge: true));
                setState(() {
                  weekData = wholeData['menu'];
                });
                _updateShowCaseData(selectedDay);
              } catch (e) {
                print('Error in setting generated data to firestore: $e');
              }
            }
          } catch (e) {
            print('Exception during Fetching Suggestions : $e');
          }
        }
      } else {
        print('genAISuggestion is missing in firestore');
      }
    } catch (e) {
      print('Error: While checking if generated Data exists or not : $e');
    }
  }

  void _updateShowCaseData(int choosenIndex) {
    setState(() {
      String choosenDay = daysLong[choosenIndex];
      Map<String, dynamic> singleDayData =
          weekData[choosenDay.toLowerCase()] ?? weekData[choosenDay];
      print('single day choosen data = $singleDayData');
      selectedDayData = singleDayData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff4F378A),
      appBar: CustomAppbar(
        rightImagePath: userPhotoURL ?? 'images/non-user.png',
        appBarColor: 'white',
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: 20,
                bottom: 20,
              ),
              child: Text.rich(
                textAlign: TextAlign.left,
                TextSpan(
                  text: 'You have 6',
                  children: [
                    TextSpan(text: 'week\nplan'),
                    TextSpan(text: ' waiting for you!'),
                  ],
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffF5F5F5),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 10,
                  children: [
                    WeekCalendar(
                      onDayChange: (int newIndex) {
                        setState(() {
                          selectedDay = newIndex;
                        });
                        _updateShowCaseData(newIndex);
                      },
                    ),
                    _recipeCardList(context, selectedDayData),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _recipeCardList(BuildContext context, Map<String, dynamic> data) {
    if (data.isNotEmpty) {
      return (Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          RecipeCardDefault(
            title: data['recipeName'],
            day: data['timeRequireToCook'],
            protein: data['macroNutrientIndex']['protein'],
            carbs: data['macroNutrientIndex']['carbs'],
            calories: data['macroNutrientIndex']['calories'],
            ingredients: data['ingredients'],
            recipe: data['recipe'] ?? data['recipeInstructions'],
            cutlery: data['cutlery'] ?? data['cutleryAndUtensils'],
          ),
        ],
      ));
    } else {
      return const CircularProgressIndicator();
    }
  }
}
