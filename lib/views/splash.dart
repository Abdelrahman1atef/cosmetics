import 'package:cosmetics/core/logic/cash_helper.dart';
import 'package:cosmetics/views/on_boarding.dart';
import 'package:flutter/material.dart';

import '../core/logic/helper_method.dart';
import '../core/network/dio_helper.dart';
import '../core/widgets/app_Image.dart';
import 'home/view.dart';
import 'login.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  Future<void> _req() async {
    final response = await DioHelper.getData("api/Auth/profile");
    if (!mounted) return;
    if(response.isSuccess) {
      goto(const HomeView(), canPop: false);
      return;
    }
    goto(const LoginView(), canPop: false);
  }
  Future<void> _handleStartup() async {
    final isFirstTime = CashHelper.getFirstTime()?? true;
    if (isFirstTime) {
      await Future<void>.delayed(const Duration(seconds: 3));
      if (!mounted) return;
      goto(const OnBoardingView(), canPop: false);
    } else {
      await _req();
    }
  }

  @override
  void initState() {
    super.initState();
    _handleStartup();
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
