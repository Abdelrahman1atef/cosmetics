// ignore_for_file: inference_failure_on_instance_creation

import 'package:cosmetics/core/widgets/app_button.dart';
import 'package:cosmetics/views/login.dart';
import 'package:flutter/material.dart';

import '../core/widgets/app_image.dart';

final pages = [
  _SplashScreensModel(
    image: "on_boarding1.png",
    text: "WELCOME!",
    subText: "Makeup has the power to transform your mood and empowers you to be a more confident person.",
  ),
  _SplashScreensModel(
    image: "on_boarding2.png",
    text: "SEARCH & PICK",
    subText: "We have dedicated set of products and routines hand picked for every skin type.",
  ),
  _SplashScreensModel(
    image: "on_boarding3.png",
    text: "PUCH NOTIFICATIONS ",
    subText: "Allow notifications for new makeup & cosmetics offers.",
  ),
];

class _SplashScreensModel {
  String image;
  String text;
  String subText;

  _SplashScreensModel({required this.image, required this.text, required this.subText});
}

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<OnBoardingView> {
  final controller = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!.toInt();
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: PageView.builder(
        controller: controller,
        itemCount: pages.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final page = pages[index];
          return Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 45),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: AlignmentGeometry.centerRight,
                  child: TextButton(
                    onPressed: () =>
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginView())),
                    child: currentPage == 2
                        ? const SizedBox.shrink()
                        : Text("Skip", style: Theme.of(context).textTheme.displayMedium),
                  ),
                ),
                Column(
                  children: [
                    AppImage(image: page.image, height: 390),
                    const SizedBox(height: 30),
                    Text(
                      page.text,
                      style: TextTheme.of(context).titleLarge?.copyWith(
                        fontFamily: 'Segoe_SemiBold',
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: ColorScheme.of(context).secondary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      page.subText,
                      style: TextTheme.of(context).titleMedium?.copyWith(
                        fontFamily: 'Segoe',
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: ColorScheme.of(context).secondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
                AppButton(
                  onPressed: () {
                    setState(() {
                      currentPage != 2
                          ? controller.jumpToPage(++currentPage)
                          : Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginView()),
                            );
                    });
                  },
                  fit:  currentPage != 2?FlexFit.loose:FlexFit.tight,
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 21),
                  margin: const EdgeInsetsDirectional.symmetric(horizontal: 30),
                  color: ColorScheme.of(context).secondary,
                  borderRadius: currentPage != 2?8:60,
                  widget: currentPage != 2
                      ? const AppImage(image: "arrow.svg")
                      : Text("let’s start!", style: TextTheme.of(context).bodyMedium),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
