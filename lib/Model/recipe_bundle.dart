

import 'package:flutter/material.dart';

class RecipeBundle {
  final int id, chefs, recipes;
  final String title, description, imageSrc;
  final Color color;

  RecipeBundle(
        this.id,
        this.chefs,
        this.recipes,
        this.title,
        this.description,
        this.imageSrc,
        this.color);
}
// Demo list
List<RecipeBundle> recipeBundles = [
  RecipeBundle(1,16,95,"Cook Something New Everyday","New and tasty recipes every minute","assets/images/cook_new@2x.png",const Color(0xFFD82D40)),
  RecipeBundle(2,8,26,"Best of 2020","Cook recipes for special occasions","assets/images/best_2020@2x.png",const Color(0xFF90AF17)),
  RecipeBundle(3,10,43,"Food Court","What's your favorite food dish make it now","assets/images/food_court@2x.png",const Color(0xFF2DBBD8))
];
