import 'package:flutter/material.dart';
import 'package:recipe/UI/View/ai_screen/ai_view.dart';
import 'package:recipe/UI/View/favourites/favourites_list.dart';
import 'package:recipe/UI/View/home/home_view.dart';
import 'package:recipe/UI/View/profile/profile_view.dart';
import 'package:recipe/UI/View/recipe_list/list_view.dart';

class NavItem {
  int id;
  String icon;
  Widget? destination;

  NavItem(this.id, this.icon, {this.destination});

// If there is no destination then it help us
  bool destinationChecker() {
    if (destination != null) {
      return true;
    }
    return false;
  }
}
// If we made any changes here Provider package rebuid those widget those use this NavItems
class NavItems extends ChangeNotifier {
  // By default first one is selected
  int selectedIndex = 0;

  void changeNavIndex(int index) {
    selectedIndex = index;
    // if any changes made it notify widgets that use the value
    notifyListeners();
  }

  List<NavItem> items = [
    NavItem(1, "assets/icons/home.svg",  destination: HomeView()),
    NavItem(2,"assets/icons/list.svg", destination: RecipeListView("All","All",null,9999)),
    NavItem(3,"assets/icons/artificial.svg", destination: aiView()),
    NavItem(4,"assets/icons/bookmark_fill.svg", destination: Favourites()),
    NavItem(5,"assets/icons/user.svg", destination: ProfileView()),
  ];
}
