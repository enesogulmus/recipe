import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe/Model/bottom_nav_bar.dart';
import 'package:recipe/Model/navigation_drawer.dart';
import 'package:recipe/Model/shared.dart';
import 'package:recipe/constants.dart';
import 'package:recipe/size_config.dart';

class Favourites extends StatefulWidget {
  final FavouriteOf? favourites;
  Favourites({this.favourites});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      drawer: NavigationDrawer(),
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  buildTextTitleVariation2('Favourite', false),
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
                children: buildFavourites(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  late List favouriteOfList;

  void setFavouriteOf(FavouriteOf favourite){
    favouriteOfList.add(
        FavouriteOf(
            favourite.title, favourite.description, favourite.image, favourite.nutrition, favourite.time, favourite.calories, favourite.carbo, favourite.protein));
  }

  List<FavouriteOf> getFavouriteOf(){
    return <FavouriteOf>[];
  }

  List<Widget> buildFavourites() {
    if (widget != null) {
      setFavouriteOf(widget.favourites!);
    }

    List<Widget> list = [];
    for (var i = 0; i < getFavouriteOf().length; i++) {
      list.add(buildFavourite(getFavouriteOf()[i]));
    }
    return list;
  }

  Widget buildFavourite(FavouriteOf favourites) {
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
                image: AssetImage(favourites.image),
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

                  buildRecipeTitle(favourites.title),

                  buildRecipeSubTitle(favourites.description),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      buildCalories(favourites.calories.toString() + " Kcal"),

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
      leading: Builder(
        builder: (BuildContext context){
          return IconButton(
            onPressed: (){
              Scaffold.of(context).openDrawer();
            },
            icon: SvgPicture.asset("assets/icons/menu.svg"),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
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

class FavouriteOf {
  String title;
  String description;
  String image;
  String nutrition;
  int time;
  int calories;
  int carbo;
  int protein;

  FavouriteOf(this.title, this.description, this.image,this.nutrition,this.time, this.calories, this.carbo, this.protein);
}

