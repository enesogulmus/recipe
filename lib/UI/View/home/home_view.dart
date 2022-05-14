import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipe/Model/bottom_nav_bar.dart';
import 'package:recipe/Model/navigation_drawer.dart';
import 'package:recipe/UI/View/home/Components/body.dart';
import 'package:recipe/constants.dart';
import 'package:recipe/size_config.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: buildAppBar(),
      body: Body(),
      // We are not able to BottomNavigationBar because the icon parameter dont except SVG
      // We also use Provied to manage the state of our Nav
      bottomNavigationBar: BottomNavBar(),
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
  }}
