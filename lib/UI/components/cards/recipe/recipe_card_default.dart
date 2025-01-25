import 'package:flutter/material.dart';
import 'package:trinetra_vallabh/UI/components/bottomSheets/recipe_info_bottom_sheet.dart';

class RecipeCardDefault extends StatelessWidget {
  final String title;
  final String day;
  final String protein;
  final String carbs;
  final String calories;
  final List ingredients;
  final List recipe;
  final List cutlery;

  const RecipeCardDefault({
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
    return InkWell(
      onTap: () {
        showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return RecipeInfoBottomSheet(
                  title: title,
                  day: day,
                  protein: protein,
                  carbs: carbs,
                  calories: calories,
                  ingredients: ingredients,
                  recipe: recipe,
                  cutlery: cutlery
                );
            });
      },
      child: Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.all(9.0), // Add padding to the card content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Icon(
                Icons.brightness_5_outlined,
                color: Color(0xff65558F),
              ), // Spacing between icon and content
              Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w900)),
              Text(day, style: Theme.of(context).textTheme.labelMedium),
              Wrap(
                spacing: 12,
                children: [
                  Chip(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    avatar: Icon(Icons.local_fire_department),
                    label: Text(
                      protein,
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
                      carbs,
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
                      calories,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
