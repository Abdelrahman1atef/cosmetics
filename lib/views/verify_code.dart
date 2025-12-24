// ignore_for_file: inference_failure_on_instance_creation

import 'package:cosmetics/core/widgets/custom_button.dart';
import 'package:cosmetics/views/home/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../core/widgets/app_Image.dart';
import '../features/auth/register.dart';
import 'login.dart';

class VerifyCodePage extends StatelessWidget {
  const VerifyCodePage({
    super.key,
    required this.isRegister,
    required this.phoneNumber,
  });

  final bool isRegister;
  final String phoneNumber;

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
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppImage(image: "app_icon.svg", width: 100),
              const SizedBox(height: 40),
              Text("Verify Code", style: TextTheme.of(context).titleLarge),
              const SizedBox(height: 40),
              BlocBuilder<RegisterCubit, RegisterState>(
                builder: (context, state) {
                  final phoneNum = phoneNumber;
                  return RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "We just sent a 4-digit verification code to\n",
                          style: TextTheme.of(context).titleMedium,
                        ),
                        TextSpan(
                          text: phoneNum,
                          style: TextTheme.of(context).displayMedium,
                        ),
                        TextSpan(
                          text:
                              ". Enter the code in the box below to continue.",
                          style: TextTheme.of(context).titleMedium,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 50),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      "Edit the number",
                      style: TextTheme.of(context).labelMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsetsGeometry.symmetric(horizontal: 60),
                child: PinCodeTextField(
                  appContext: context,
                  length: 4,
                  textStyle: TextTheme.of(context).displayMedium?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  hintCharacter: "–",
                  hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 25,
                    fontVariations: <FontVariation>[
                      const FontVariation('wght', 700),
                    ],
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  cursorColor: Theme.of(context).hintColor,
                  cursorWidth: 3,
                  pinTheme: PinTheme(
                    fieldWidth: 60,
                    fieldHeight: 60,
                    borderRadius: BorderRadius.circular(12),
                    shape: PinCodeFieldShape.box,
                    inactiveColor: Theme.of(context).hintColor,
                    selectedColor: Theme.of(context).colorScheme.primary,
                    activeColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 50),

              ///todo add timer for resend code
              GestureDetector(
                onTap: () {},
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Didn’t receive a code? ",
                        style: TextTheme.of(context).titleMedium?.copyWith(
                          fontSize: 18,
                          color: ColorScheme.of(context).secondary,
                        ),
                      ),
                      TextSpan(
                        text: " Resend",
                        style: TextTheme.of(context).labelMedium?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),

              CustomButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Theme.of(
                        context,
                      ).scaffoldBackgroundColor,
                      shape: RoundedSuperellipseBorder(
                        borderRadius: BorderRadiusGeometry.circular(30),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 360,
                        minHeight: 343,
                      ),
                      icon: CircleAvatar(
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.5),
                        radius: 60,
                        child: CircleAvatar(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.7),
                          radius: 50,
                          child: CircleAvatar(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            radius: 40,
                            child: SvgPicture.asset(
                              "assets/svgs/done_task.svg",
                            ),
                          ),
                        ),
                      ),
                      alignment: Alignment.center,
                      title: Text(
                        isRegister ? "Account Activated!" : "Password Created!",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      content: Text(
                        isRegister
                            ? "Congratulations! Your account has been successfully activated"
                            : "Congratulations! Your password has been successfully created",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      actions: [
                        CustomButton(
                          width: 90,
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => isRegister
                                    ? const MainView()
                                    : const LoginPage(),
                              ),
                              (route) => false,
                            );
                          },
                          child: Text(
                            isRegister ? "Go to home" : "Return to login",
                            style: TextTheme.of(context).bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Text("Done", style: TextTheme.of(context).bodyMedium),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
