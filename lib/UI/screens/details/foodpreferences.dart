// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:trinetra_vallabh/UI/components/custom_appbar.dart';

class FoodPreferences extends StatefulWidget {
  const FoodPreferences({super.key});

  @override
  State<FoodPreferences> createState() => _FoodPreferencesState();
}

enum DietaryPreferences { vegetarian, nonvegetarian, vegan }

enum CookinExperience { beginner, intermediate, advanced }

class _FoodPreferencesState extends State<FoodPreferences> {
  Set<DietaryPreferences> selectionDietaryPreference = <DietaryPreferences>{
    DietaryPreferences.vegetarian
  };
  Set<CookinExperience> selectionCookingExperience = <CookinExperience>{
    CookinExperience.intermediate
  };
  double _currentSliderSpiceCount = 20;
  double _currentSliderSweetHotCount = 20;

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
                Text('SECTION TWO',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.black.withOpacity(0.5))),
                SizedBox(height: 10),
                Text('Your food preferences',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Color(0xff250F5E), fontWeight: FontWeight.w600)),
                SizedBox(height: 10),
                Text(
                    'This will allow us draft better health goals and time table for you',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Dietary Preferences',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<DietaryPreferences>(
                    segments: const <ButtonSegment<DietaryPreferences>>[
                      ButtonSegment<DietaryPreferences>(
                        value: DietaryPreferences.vegetarian,
                        label: Text(
                          'Vegetarian',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w500),
                        ),
                      ),
                      ButtonSegment<DietaryPreferences>(
                        value: DietaryPreferences.nonvegetarian,
                        label: Text(
                          'Non-Vegetarian',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w500),
                        ),
                      ),
                      ButtonSegment<DietaryPreferences>(
                        value: DietaryPreferences.vegan,
                        label: Text(
                          'Vegan',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                    selected: selectionDietaryPreference,
                    onSelectionChanged:
                        (Set<DietaryPreferences> newDietaryPreference) {
                      setState(() {
                        selectionDietaryPreference = newDietaryPreference;
                      });
                    },
                    multiSelectionEnabled: false,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Dietary Preferences',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<CookinExperience>(
                    segments: const <ButtonSegment<CookinExperience>>[
                      ButtonSegment<CookinExperience>(
                        value: CookinExperience.beginner,
                        label: Text(
                          'Beginner',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w500),
                        ),
                      ),
                      ButtonSegment<CookinExperience>(
                        value: CookinExperience.intermediate,
                        label: Text(
                          'Intermediate',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w500),
                        ),
                      ),
                      ButtonSegment<CookinExperience>(
                        value: CookinExperience.advanced,
                        label: Text(
                          'Advanced',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                    selected: selectionCookingExperience,
                    onSelectionChanged:
                        (Set<CookinExperience> newCookingExperience) {
                      setState(() {
                        selectionCookingExperience = newCookingExperience;
                      });
                    },
                    multiSelectionEnabled: false,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.cancel),
                    labelText: 'Meal Count',
                    hintText: '2',
                    helperText: 'Number of meals consumed in a day',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Slider(
                  value: _currentSliderSpiceCount,
                  max: 100,
                  divisions: 5,
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderSpiceCount = value;
                    });
                  },
                ),
                Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sentiment_neutral,
                          color: Color(0xff65558F),
                        ),
                        Text(
                          'No Spice',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Color(0xff65558F),
                                  ),
                        )
                      ],
                    ),
                    Spacer(),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sentiment_neutral,
                          color: Color(0xff65558F),
                        ),
                        Text(
                          'Very Spicy',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Color(0xff65558F),
                                  ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Slider(
                  value: _currentSliderSweetHotCount,
                  max: 100,
                  divisions: 5,
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderSweetHotCount = value;
                    });
                  },
                ),
                Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cake,
                          color: Color(0xff65558F),
                        ),
                        Text(
                          'Sweet',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Color(0xff65558F),
                                  ),
                        )
                      ],
                    ),
                    Spacer(),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: Color(0xff65558F),
                        ),
                        Text(
                          'Hot',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Color(0xff65558F),
                                  ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ScheduleDetailsPage(),
            //   ),
            // );
          },
          child: Icon(Icons.arrow_right_alt),
        ));
  }
}
