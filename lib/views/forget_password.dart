import 'package:flutter/material.dart';

import '../core/widgets/app_Image.dart';
import '../core/widgets/custom_button.dart';
import '../core/widgets/custom_dropdownmenu.dart';
import '../core/widgets/custom_textformfield.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

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
            const AppImage(image:"assets/images/app_icon.svg", width: 100),
            const SizedBox(height:60),
            Text("Forget Password", style: TextTheme.of(context).titleLarge),
            const SizedBox(height:60),
            Text(
              "Please enter your phone number below to recovery your password.",
              style: TextTheme.of(context).titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height:40),
            const Form(
              child: Column(
                children: [
                  Row(
                    children: [
                      ///Todo style dropdown menu
                      ///Todo add validator
                      CustomDropdownMenu(),
                      SizedBox(width:6),
                      Expanded(
                        ///Todo add validator
                        child: CustomTextFormField(labelText: "Phone Number"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height:60),
            CustomButton(
              ///Todo add validator to nav
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         const VerifyCodePage(isRegister: false),
                //   ),
                // );
              },
              child: Text("Next", style: TextTheme.of(context).bodyMedium),
            ),
          ],
        ),
      ),
    );
  }
}
