import 'package:cosmetics/views/login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../core/network/api_constant.dart';
import '../core/network/dio_helper.dart';
import '../core/widgets/app_image.dart';
import '../core/widgets/app_button.dart';
import '../core/widgets/app_input.dart';

class CreatePasswordView extends StatefulWidget {
  const CreatePasswordView({super.key, required this.countryCode, required this.phoneNumber});
  final  String countryCode;
  final String phoneNumber;

  @override
  State<CreatePasswordView> createState() => _CreatePasswordViewState();
}

class _CreatePasswordViewState extends State<CreatePasswordView> {
  final _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();


  void _reqValidation(BuildContext context, Response<dynamic> response) {
    showDialog<void>(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    if (response.data == null || response.statusCode != 200) {
      Navigator.pop(context);
      final data = response.data['message'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          content: Text(data, style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white)),
        ),
      );
      return;
    }
    if (response.data != null || response.statusCode == 200) {
      Navigator.pop(context);
      showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            shape: RoundedSuperellipseBorder(borderRadius: BorderRadiusGeometry.circular(30)),
            constraints: const BoxConstraints(minWidth: 360, minHeight: 343),
            icon: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
              radius: 60,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.7),
                radius: 50,
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  radius: 40,
                  child: const AppImage(image: "done_task.svg"),
                ),
              ),
            ),
            alignment: Alignment.center,
            title: Text("Password Created!", style: Theme.of(context).textTheme.displayMedium),
            content: Text(
              "Congratulations! Your password has been successfully created",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            actions: [
              AppButton(
                width: 90,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute<void>(builder: (context) => const LoginView()));
                },
                text: "Return to login",
              ),
            ],
          );
        },
      );
    }
  }

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
            const AppImage(image: "app_icon.svg", width: 100),
            const SizedBox(height: 60),
            Text("Create Password", style: TextTheme.of(context).titleLarge),
            const SizedBox(height: 60),
            Text(
              "The password should have at least 6 characters.",
              style: TextTheme.of(context).titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Form(
              key: _key,
              child: Column(
                children: [
                  AppInput(
                    controller: _passwordController,
                    labelText: "New password",
                    isPasswordField: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your New password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  AppInput(
                    controller: _confirmPasswordController,
                    labelText: "Confirm password",
                    isPasswordField: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Confirm password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
            AppButton(
              onPressed: () async{
                if (_key.currentState!.validate()) {
                  final data = {
                    "countryCode": widget.countryCode,
                    "phoneNumber": widget.phoneNumber,
                    "newPassword": _passwordController.text,
                    "confirmPassword": _confirmPasswordController.text,
                  };
                  final response = await DioHelper().postData(endpoint: ApiConstant.resetPassword, data: data);
                  if (context.mounted) {
                    _reqValidation(context, response);
                  }
                }
              },
              text: "Next",
            ),
          ],
        ),
      ),
    );
  }
}
