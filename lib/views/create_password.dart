import 'package:cosmetics/views/login.dart';
import 'package:cosmetics/views/success_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../core/logic/helper_method.dart';
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


  void _req(BuildContext context, Map<String,dynamic> data) async{

    final response = await DioHelper.postData(endpoint: "api/Auth/reset-password", data: data);

    showDialog<void>(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    if (response.isSuccess) {
      Navigator.pop(context);
      final msg = response.data['message'];
      showMsg(msg);
      return;
    }
    Navigator.pop(context);
    showDialog<void>(
      context: context,
      builder: (context) {
        return const SuccessDialog(isRegister: false,);
      },
    );
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
                  if (context.mounted) {
                    _req(context, data);
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
