import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe/UI/View/favourites/favourites_list.dart';
import 'package:recipe/constants.dart';
import 'package:recipe/size_config.dart';


class ProfileMenuItem extends StatelessWidget {
  final String iconSrc, title;
  final void Function() press;
  ProfileMenuItem(this.iconSrc,this.title,this.press);
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return InkWell(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: defaultSize * 2, vertical: defaultSize * 3),
        child: SafeArea(
          child: Row(
            children: <Widget>[
              IconButton(onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Favourites()));
              }, icon:SvgPicture.asset(iconSrc)),
              SizedBox(width: defaultSize * 2),
              TextButton(
                onPressed: () { Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Favourites())); },
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: defaultSize * 1.6, //16
                    color: kTextLightColor,
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: defaultSize * 1.6,
                  color: kTextLightColor,
                ),
                onPressed: () { Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Favourites())); },
              )
            ],
          ),
        ),
      ),
    );
  }
}
