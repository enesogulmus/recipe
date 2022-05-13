import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:recipe/Model/nav_item.dart';
import 'package:recipe/constants.dart';
import 'package:recipe/size_config.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Consumer<NavItems>(
      builder: (context, navItems, child) => Container(
        padding: EdgeInsets.symmetric(horizontal: defaultSize * 3), //30
        // just for demo
        // height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -7),
              blurRadius: 30,
              color: const Color(0xFF4B1A39).withOpacity(0.2),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              navItems.items.length,
              (index) => buildIconNavBarItem(navItems.items[index].icon,() {
                navItems.changeNavIndex(index);
                // maybe destinationChacker is not needed in future because then all of our nav items have destination
                // But Now if we click those which dont have destination then it shows error
                // And this fix this problem
                if (navItems.items[index].destinationChecker()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavItems().items[index].destination!,
                    ),
                  );
                }
              },navItems.selectedIndex == index ? true : false),
            ),
          ),
        ),
      ),
    );
  }
  IconButton  buildIconNavBarItem(String icon, void Function() press, bool bool, {bool isActive = false}) {
    return IconButton(
      icon: SvgPicture.asset(
        icon,
        color: isActive ? kPrimaryColor : const Color(0xFFD1D4D4),
        height: 22,
      ),
      onPressed: press,
    );
  }
}
