import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe/Model/recipe_bundle.dart';
import 'package:recipe/UI/View/recipe_list/list_view.dart';
import 'package:recipe/size_config.dart';

class RecipeBundleCard extends StatelessWidget {
  final RecipeBundle recipeBundle;
  final void Function() press;
  RecipeBundleCard(this.recipeBundle, this.press);

  @override
  Widget build(BuildContext context) {
      double defaultSize = SizeConfig.defaultSize;
      // Now we dont this Aspect ratio
      return GestureDetector(
        onTap: press,
        child: Container(
          decoration: BoxDecoration(
            color: recipeBundle.color,
            borderRadius: BorderRadius.circular(defaultSize * 1.8), //18
          ),
          child: MaterialButton(
            onPressed: ( ) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecipeListView(null, null, null, null)),
              );
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(defaultSize * 2), //20
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Spacer(),
                        Text(
                          recipeBundle.title,
                          style: TextStyle(
                              fontSize: defaultSize * 2.2, //22
                              color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: defaultSize * 0.5), // 5
                        Text(
                          recipeBundle.description,
                          style: const TextStyle(color: Colors.white54),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        buildInfoRow(defaultSize,"assets/icons/pot.svg","${recipeBundle.recipes} Recipes"),
                        SizedBox(height: defaultSize * 0.5), //5
                        buildInfoRow(defaultSize,"assets/icons/chef.svg","${recipeBundle.chefs} Chefs"),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: defaultSize * 0.5), //5
                AspectRatio(
                  aspectRatio: 0.71,
                  child: Image.asset(
                    recipeBundle.imageSrc,
                    fit: BoxFit.cover,
                    alignment: Alignment.centerLeft,
                  ),
                )
              ],
            ),
          ),
        )
        );
    }
  }

  Row buildInfoRow(double defaultSize, String iconSrc, text) {
    return Row(
      children: <Widget>[
        SvgPicture.asset(iconSrc),
        SizedBox(width: defaultSize), // 10
        Text(
          text,
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
  }
