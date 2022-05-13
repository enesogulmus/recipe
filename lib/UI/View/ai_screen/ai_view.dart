import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe/UI/View/ai_screen/Components/body.dart';
import 'package:recipe/constants.dart';
import 'package:recipe/size_config.dart';

class aiView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: App(),
      );
  }
}
