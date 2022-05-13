import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipe/Core/SERVICES/data.dart';
import 'package:recipe/Model/bottom_nav_bar.dart';
import 'package:recipe/Model/shared.dart';
import 'package:recipe/UI/View/recipe_detail/detail_view.dart';
import 'package:recipe/constants.dart';
import 'package:recipe/size_config.dart';

class RecipeListView extends StatefulWidget {
  String? nutritionPrefer;
  String? anyDiet;
  List? noIngredients;
  int? time;
  RecipeListView(this.nutritionPrefer, this.anyDiet, this.noIngredients, this.time);

  @override
  State<RecipeListView> createState() => _RecipeListViewState();
}

class _RecipeListViewState extends State<RecipeListView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),

            Container(
              height: 350,
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: buildRecipes(),
              ),
            ),

            SizedBox(
              height: 16,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  buildTextTitleVariation2('Popular', false),
                  SizedBox(
                    width: 8,
                  ),
                  buildTextTitleVariation2('Food', true),
                ],
              ),
            ),

            Container(
              height: 190,
              child: PageView(
                physics: BouncingScrollPhysics(),
                children: buildPopulars(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  List<Widget> buildRecipes() {
    List<Widget> list = [];
    if(widget.time != null) {
      for (var i = 0; i < getRecipes().length; i++) {
        if (widget.nutritionPrefer == getRecipes()[i].nutrition || widget.anyDiet == "no") {
          if (widget.nutritionPrefer == "Vegetable" || getRecipes()[i].calories > 245) {
            if (getRecipes()[i].time <= widget.time!) {
              list.add(buildRecipe(getRecipes()[i], i));
            }
          }
        }
      }
    }
    if(widget.time != null) {
      for (var i = 0; i < getRecipes().length; i++) {
        if (widget.nutritionPrefer == getRecipes()[i].nutrition || widget.anyDiet == "no") {
          if (widget.nutritionPrefer == "Normal" || getRecipes()[i].calories > 287) {
            if (getRecipes()[i].time <= widget.time!) {
              list.add(buildRecipe(getRecipes()[i], i));
            }
          }
        }
      }
    }
    if(widget.time != null) {
      for (var i = 0; i < getRecipes().length; i++) {
        if (widget.nutritionPrefer == getRecipes()[i].nutrition || widget.anyDiet == "no") {
          if (widget.nutritionPrefer == "Vegan" || getRecipes()[i].calories > 319) {
            if (getRecipes()[i].time <= widget.time!) {
              list.add(buildRecipe(getRecipes()[i], i));
            }
          }
        }
      }
    }
    if(widget.time != null) {
      for (var i = 0; i < getRecipes().length; i++) {
        if (widget.nutritionPrefer == getRecipes()[i].nutrition || widget.anyDiet == "yes") {
          if (widget.nutritionPrefer == "Vegetable" || getRecipes()[i].calories < 245) {
            if (getRecipes()[i].time <= widget.time!) {
              list.add(buildRecipe(getRecipes()[i], i));
            }
          }
        }
      }
    }
    if(widget.time != null) {
      for (var i = 0; i < getRecipes().length; i++) {
        if (widget.nutritionPrefer == getRecipes()[i].nutrition || widget.anyDiet == "yes") {
          if (widget.nutritionPrefer == "Normal" || getRecipes()[i].calories < 287) {
            if (getRecipes()[i].time <= widget.time!) {
              list.add(buildRecipe(getRecipes()[i], i));
            }
          }
        }
      }
    }
    if(widget.time != null) {
      for (var i = 0; i < getRecipes().length; i++) {
        if (widget.nutritionPrefer == getRecipes()[i].nutrition || widget.anyDiet == "no") {
          if (widget.nutritionPrefer == "Vegan" || getRecipes()[i].calories < 319) {
            if (getRecipes()[i].time <= widget.time!) {
              list.add(buildRecipe(getRecipes()[i], i));
            }
          }
        }
      }
    }
    return list;
  }

  Widget buildRecipe(Recipe recipe, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detail(recipe: recipe)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [kBoxShadow],
        ),
        margin: EdgeInsets.only(
            right: 16, left: index == 0 ? 16 : 0, bottom: 16, top: 8),
        padding: EdgeInsets.all(16),
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Expanded(
              child: Hero(
                tag: recipe.image,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(recipe.image),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 8,
            ),

            buildRecipeTitle(recipe.title),

            buildTextSubTitleVariation2(recipe.description),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                buildCalories(recipe.calories.toString() + " Kcal"),

                Icon(
                  Icons.favorite_border,
                )

              ],
            ),

          ],
        ),
      ),
    );
  }

  List<Widget> buildPopulars() {
    List<Widget> list = [];
    for (var i = 0; i < getRecipes().length; i++) {
      list.add(buildPopular(getRecipes()[i]));
    }
    return list;
  }

  Widget buildPopular(Recipe recipe) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [kBoxShadow],
      ),
      child: Row(
        children: [

          Container(
            height: 160,
            width: 160,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(recipe.image),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  buildRecipeTitle(recipe.title),

                  buildRecipeSubTitle(recipe.description),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      buildCalories(recipe.calories.toString() + " Kcal"),

                      Icon(
                        Icons.favorite_border,
                      )

                    ],
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }


  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kBackGroundColor,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {},
      ),
      // On Android by default its false
      centerTitle: true,
      title: Image.asset("assets/images/logo.png"),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {},
        ),
        SizedBox(
          // It means 5 because by out defaultSize = 10
          width: SizeConfig.defaultSize * 0.5,
        )
      ],
    );
  }
}
