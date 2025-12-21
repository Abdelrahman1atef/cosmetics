// ignore_for_file: inference_failure_on_instance_creation

import 'package:cosmetics/core/widgets/custom_button.dart';
import 'package:cosmetics/views/login.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';


class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<OnboardingPage> {
  PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorScheme.of(context).primary,
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: pages
            .map(
              (screen) => Padding(
                padding: const EdgeInsetsGeometry.symmetric(horizontal: 45),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(screen.image, height: 390),
                    const Gap(30),
                    Text(screen.text,style: TextTheme.of(context).titleLarge?.copyWith(
                      fontFamily: 'Segoe_SemiBold',
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: ColorScheme.of(context).secondary,
                    ),),
                    const Gap(10),
                    Text(
                      screen.subText,
                      style: TextTheme.of(context).titleMedium?.copyWith(
                        fontFamily: 'Segoe',
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: ColorScheme.of(context).secondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(30),
                    CustomButton(
                      isChildIcon: currentPage != 2 ? true : false,
                      onPressed: () {
                        setState(() {
                          currentPage != 2
                              ? pageController.animateToPage(
                                  ++currentPage,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.linear,
                                )
                              : Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                        });
                      },
                      color: ColorScheme.of(context).secondary
                      , width: 90,
                      child: currentPage != 2
                          ? const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                              size: 35,
                            )
                          : Text(
                              "let’s start!",
                              style: TextTheme.of(context).bodyMedium,
                            ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  List<SplashScreensModel> pages = [
    SplashScreensModel(
      image: "assets/on_boarding/on_boarding1.png",
      text: "WELCOME!",
      subText:
          "Makeup has the power to transform your mood and empowers you to be a more confident person.",
    ),
    SplashScreensModel(
      image: "assets/on_boarding/on_boarding2.png",
      text: "SEARCH & PICK",
      subText:
          "We have dedicated set of products and routines hand picked for every skin type.",
    ),
    SplashScreensModel(
      image: "assets/on_boarding/on_boarding3.png",
      text: "PUCH NOTIFICATIONS ",
      subText: "Allow notifications for new makeup & cosmetics offers.",
    ),
  ];
}

class SplashScreensModel {
  String image;
  String text;
  String subText;

  SplashScreensModel({
    required this.image,
    required this.text,
    required this.subText,
  });
}
