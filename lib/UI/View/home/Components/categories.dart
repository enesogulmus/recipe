import 'package:flutter/material.dart';
import 'package:recipe/UI/View/recipe_list/list_view.dart';
import 'package:recipe/constants.dart';
import 'package:recipe/size_config.dart';

// Our Category List need StateFullWidget
// I can use Provider on it, Then we dont need StatefulWidget

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}
class _CategoriesState extends State<Categories> {
  List<String> categories = ["All", "Vegetable", "Normal", "Vegan"];
  // By default first one is selected
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 2),
      child: SizedBox(
        height: SizeConfig.defaultSize * 5, // 35
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategorieItem(index),
        ),
      ),
    );
  }

  Widget buildCategorieItem(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: SizeConfig.defaultSize * 2),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultSize * 2, //20
          vertical: SizeConfig.defaultSize * 0.5, //5
        ),
        decoration: BoxDecoration(
            color:
            selectedIndex == index ? const Color(0xFFEFF3EE) : Colors.transparent,
            borderRadius: BorderRadius.circular(
              SizeConfig.defaultSize * 1.6, // 16
            )),
        child: TextButton(
          child: Text(
            categories[index],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: selectedIndex == index ? kPrimaryColor : const Color(0xFFC2C2B5),
            ),
          ),
          onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder:
                        (BuildContext context) => RecipeListView(categories[index], "All", null, 9999)));
          },
        ),
      ),
    );
  }
}
