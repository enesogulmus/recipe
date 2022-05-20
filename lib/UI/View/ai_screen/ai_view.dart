import 'package:flutter/material.dart';
import 'package:recipe/UI/View/ai_screen/Components/body.dart';
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
