// ignore_for_file: inference_failure_on_instance_creation

import 'package:cosmetics/core/widgets/app_button.dart';
import 'package:cosmetics/core/widgets/app_drop_menu.dart';
import 'package:cosmetics/views/forget_password.dart';
import 'package:cosmetics/views/register.dart';
import 'package:flutter/material.dart';
import '../core/widgets/app_image.dart';
import '../core/widgets/app_input.dart';
import 'home/view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsetsGeometry.directional(
          top: kToolbarHeight + 50,
          bottom: kToolbarHeight - 40,
          start: 13,
          end: 13,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsetsGeometry.directional(end: 20),
              child: const AppImage(image:"login.png", width: 380),
            ),
            Text("Login Now", style: TextTheme.of(context).titleLarge),
            const SizedBox(height:14),
            Text(
              "Please enter the details below to continue",
              style: TextTheme.of(context).titleMedium,
            ),
            const SizedBox(height:25),
            const Form(
              child: Column(
                children: [
                  Row(
                    children: [
                      ///Todo style dropdown menu
                      ///Todo add validator
                      AppDropMenu(),
                      SizedBox(width:6),
                      Expanded(
                        ///Todo add validator
                        child: AppInput(labelText: "Phone Number"),
                      ),
                    ],
                  ),
                  SizedBox(height:16),

                  ///Todo add validator
                  AppInput(labelText: "Your Password"),
                ],
              ),
            ),
            const SizedBox(height:20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  ///Todo add Forget password screen nav
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgetPasswordView(),
                    ),
                  ),
                  child: Text(
                    "Forget Password?",
                    style: TextTheme.of(context).labelMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height:40),
            AppButton(
              isChildIcon: false,

              ///Todo add validator to nav
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeView()),
                );
              },
              child: Text("Login", style: TextTheme.of(context).bodyMedium),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsetsGeometry.symmetric(vertical: 20),
        child: GestureDetector(
          onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const RegisterView()),
          ),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Don’t have an account?",
                  style: TextTheme.of(context).titleMedium?.copyWith(
                    fontSize: 18,
                    color: ColorScheme.of(context).secondary,
                  ),
                ),
                const WidgetSpan(child: SizedBox(width: 10)),
                TextSpan(
                  text: "Register",
                  style: TextTheme.of(context).labelMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
