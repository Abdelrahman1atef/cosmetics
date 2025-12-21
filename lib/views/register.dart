// ignore_for_file: inference_failure_on_instance_creation

import 'package:cosmetics/views/login.dart';
import 'package:cosmetics/views/verify_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../core/widgets/custom_button.dart';
import '../core/widgets/custom_dropdownmenu.dart';
import '../core/widgets/custom_textformfield.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorScheme.of(context).primary,
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
            SvgPicture.asset("assets/svgs/app_icon.svg", width: 100),
            const Gap(40),
            Text("Create Account", style: TextTheme.of(context).titleLarge),
            const Gap(80),
            const Form(
              child: Column(
                children: [
                  CustomTextFormField(labelText: "Your Name"),
                  Gap(16),
                  Row(
                    children: [
                      ///Todo style dropdown menu
                      ///Todo add validator
                      CustomDropdownMenu(),
                      Gap(6),
                      Expanded(
                        ///Todo add validator
                        child: CustomTextFormField(labelText: "Phone Number"),
                      ),
                    ],
                  ),
                  Gap(16),

                  ///Todo add validator
                  CustomTextFormField(
                    labelText: "Create your password",
                    isPasswordField: true,
                  ),
                  Gap(16),
                  CustomTextFormField(
                    labelText: "Confirm password",
                    isPasswordField: true,
                  ),
                ],
              ),
            ),
            const Gap(80),
            CustomButton(
              isChildIcon: false,

              ///Todo add validator to nav
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VerifyCodePage(isRegister: true,),
                  ),
                );
              },
              child: Text("Next", style: TextTheme.of(context).bodyMedium),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsetsGeometry.symmetric(vertical: 20),
        child: GestureDetector(
          onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          ),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Have an account?",
                  style: TextTheme.of(context).titleMedium?.copyWith(
                    fontSize: 18,
                    color: ColorScheme.of(context).secondary,
                  ),
                ),
                const WidgetSpan(child: SizedBox(width: 10)),
                TextSpan(
                  text: " login",
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
