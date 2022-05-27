import 'package:flutter/material.dart';
import 'package:recipe/Model/bottom_nav_bar.dart';
import 'package:recipe/UI/View/profile/Components/body.dart';
import 'package:recipe/constants.dart';
import 'package:recipe/size_config.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: SizedBox(),
        // On Android it's false by default
        centerTitle: true,
        title: Text("Profile"),
        actions: <Widget>[
/*          TextButton.icon(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: Icon(Icons.exit_to_app_outlined),
            label: Text('Log Out',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.defaultSize * 1.6, //16
                  fontWeight: FontWeight.bold),
            ),
          )*/
        ],
      ),
      body: Body(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
