import 'package:cosmetics/views/home/pages/cart.dart';
import 'package:cosmetics/views/home/pages/categories.dart';
import 'package:cosmetics/views/home/pages/home.dart';
import 'package:cosmetics/views/home/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> screens = [
    const HomePage(),
    const CategoriesPage(),
    const CartPage(),
    const ProfilePage(),
  ];
  int currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: IndexedStack(index: currentScreen, children: screens),
      bottomNavigationBar: Container(
        margin: const EdgeInsetsGeometry.directional(start: 13,end: 13,bottom: 15,top: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadiusGeometry.circular(25),
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 2)
            ),
          ]
        ),
        child: BottomNavigationBarTheme(
          data: const BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            backgroundColor: Colors.transparent,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            enableFeedback: false,
          ),
          child: BottomNavigationBar(
            currentIndex: currentScreen,
            onTap: (value) {
              setState(() {
                currentScreen = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/svgs/unselected_home.svg",width: 30,),
                activeIcon: SvgPicture.asset("assets/svgs/selected_home.svg",width: 30,),
                tooltip: "Home",
                label: "",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/svgs/unselected_categories.svg",width: 30,),
                activeIcon: SvgPicture.asset("assets/svgs/selected_categories.svg",width: 30,),
                tooltip: "Categories",
                label: "",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/svgs/unselected_cart.svg",width: 30,),
                activeIcon: SvgPicture.asset("assets/svgs/selected_cart.svg",width: 30,),
                tooltip: "Cart",
                label: "",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/svgs/unselected_profile.svg",width: 30,),
                activeIcon: SvgPicture.asset("assets/svgs/selected_profile.svg",width: 30,),
                tooltip: "Profile",
                label: "",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
