import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe/UI/View/ai_screen/ai_view.dart';
import 'package:recipe/UI/View/favourites/favourites_list.dart';
import 'package:recipe/UI/View/home/home_view.dart';
import 'package:recipe/UI/View/profile/profile_view.dart';
import 'package:recipe/UI/View/recipe_list/list_view.dart';

class NavigationDrawer extends StatelessWidget {


  @override
  Widget build(BuildContext context) => Drawer(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildMenuItems(context),
        ]
      ),
    ),
  );

    Widget buildHeader(BuildContext context) => Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    );

    Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeView()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Recipe List'),
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeListView("All","All",null,9999)));},
          ),
          ListTile(
            leading: const Icon(Icons.workspaces_outline),
            title: const Text('AI Helper'),
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => aiView()));},
          ),
          ListTile(
            leading: const Icon(Icons.favorite_border),
            title: const Text('Favourites'),
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Favourites()));},
          ),
          ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: const Text('Profile'),
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileView()));},
          ),
          const Divider(color: Colors.black54),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileView()));},
          )
        ],
      ),
    );
  }
