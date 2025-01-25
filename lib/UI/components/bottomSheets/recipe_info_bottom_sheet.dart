import 'package:flutter/material.dart';
import 'package:super_bullet_list/bullet_list.dart';

class RecipeInfoBottomSheet extends StatelessWidget {
  final String title;
  final String day;
  final String protein;
  final String carbs;
  final String calories;
  final List ingredients;
  final List recipe;
  final List cutlery;

  const RecipeInfoBottomSheet({
    super.key,
    required this.title,
    required this.day,
    required this.protein,
    required this.carbs,
    required this.calories,
    required this.ingredients,
    required this.recipe,
    required this.cutlery,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height: 700,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 18,
            left: 16,
            right: 16,
            bottom: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Center(
                child: SizedBox(
                  width: 389,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: 389,
                        height: 98,
                        child: Image.asset(
                          'images/Ellipse-seven.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.topCenter,
                          // ignore: sized_box_for_whitespace
                          child: Container(
                            width: double.infinity,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: 8,
                                  children: [
                                    Text(
                                      title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w900),
                                    ),
                                    Text(day,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    Chip(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      avatar: Icon(Icons.local_fire_department),
                      label: Text(
                        'Calories $protein',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Chip(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      avatar: Icon(Icons.spa_outlined),
                      label: Text(
                        'Carbs $carbs',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Chip(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      avatar: Icon(Icons.water_drop_outlined),
                      label: Text(
                        'Calories $calories',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _bulletPoints(context, ingredients),
              SizedBox(
                height: 10,
              ),
              _bulletPoints(context, recipe),
              SizedBox(
                height: 10,
              ),
              _bulletPoints(context, cutlery),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bulletPoints(BuildContext context, List arrList) {
    return (Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Ingredients',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Color(0xff6B579D),
              ),
        ),
        SizedBox(
          height: 5,
        ),
        SuperBulletList(
          isOrdered: false,
          items: List.generate(arrList.length, (index) {
            String txt = arrList[index];
            return Text(
              txt,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Color(0xff4A4A4A),
                  ),
            );
          }),
        ),
      ],
    ));
  }
}
