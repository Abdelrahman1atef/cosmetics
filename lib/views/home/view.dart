import 'package:cosmetics/views/home/pages/cart/view.dart';
import 'package:cosmetics/views/home/pages/categories.dart';
import 'package:cosmetics/views/home/pages/home.dart';
import 'package:cosmetics/views/home/pages/profile.dart';
import 'package:flutter/material.dart';

import '../../core/widgets/app_image.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final screens = [
    const HomePage(),
    const CategoriesPage(),
    const CartPage(),
    const ProfilePage(),
  ];
  int currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentScreen, children: screens),
      bottomNavigationBar: Container(
        margin: const EdgeInsetsGeometry.directional(start: 13,end: 13,bottom: 15,top: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadiusGeometry.circular(25),
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              offset: const Offset(-4, -4),
              spreadRadius: 0,
              blurRadius: 6,
              color: Colors.black.withValues(alpha: 0.1),
            ),
            BoxShadow(
              offset: const Offset(4, 4),
              spreadRadius: 0,
              blurRadius: 4,
              color: Colors.black.withValues(alpha: 0.1),
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
            items: const [
              BottomNavigationBarItem(
                icon: AppImage(image:"unselected_home.svg",width: 30,),
                activeIcon: AppImage(image:"selected_home.svg",width: 30,),
                tooltip: "Home",
                label: "",
              ),
              BottomNavigationBarItem(
                icon: AppImage(image:"unselected_categories.svg",width: 30,),
                activeIcon: AppImage(image:"selected_categories.svg",width: 30,),
                tooltip: "Categories",
                label: "",
              ),
              BottomNavigationBarItem(
                icon: AppImage(image:"unselected_cart.svg",width: 30,),
                activeIcon: AppImage(image:"selected_cart.svg",width: 30,),
                tooltip: "Cart",
                label: "",
              ),
              BottomNavigationBarItem(
                icon: AppImage(image:"unselected_profile.svg",width: 30,),
                activeIcon: AppImage(image:"selected_profile.svg",width: 30,),
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
