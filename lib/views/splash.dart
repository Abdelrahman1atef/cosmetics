import 'package:cosmetics/views/on_boarding.dart';
import 'package:flutter/material.dart';

import '../core/widgets/app_Image.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    if (context.mounted) {
      Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context, MaterialPageRoute<void>(builder: (context) => const OnBoardingView())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppImage(image: 'app_icon.svg'),
            AppImage(image: "splash_image2.svg"),
          ],
        ),
      ),
    );
  }
}
