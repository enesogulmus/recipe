import 'package:flutter/material.dart';
import 'package:recipe/size_config.dart';
import 'info.dart';
import 'profile_menu_item.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: <Widget>[
            Info(),
            SizedBox(height: SizeConfig.defaultSize * 2), //20
            ProfileMenuItem("assets/icons/bookmark_fill.svg","Saved Recipes", () {}),
            ProfileMenuItem("assets/icons/chef_color.svg","Super Plan",() {}),
            ProfileMenuItem("assets/icons/language.svg","Change Language",() {}),
            ProfileMenuItem("assets/icons/info.svg","Help",() {}),
          ],
        ),
    );
  }
}
