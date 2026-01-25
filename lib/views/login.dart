// ignore_for_file: inference_failure_on_instance_creation

import 'package:cosmetics/core/widgets/app_button.dart';
import 'package:cosmetics/core/widgets/app_drop_menu.dart';
import 'package:cosmetics/views/forget_password.dart';
import 'package:cosmetics/views/register.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../core/network/api_constant.dart';
import '../core/network/dio_helper.dart';
import '../core/widgets/app_image.dart';
import '../core/widgets/app_input.dart';
import 'home/view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _key = GlobalKey<FormState>();
  final _countryCodeController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _countryCodeController.text = "+20";
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
      print(response.data["token"]);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeView()),
        (route) => false);
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
            Container(
              margin: const EdgeInsetsGeometry.directional(end: 20),
              child: const AppImage(image: "login.png", width: 380),
            ),
            Text("Login Now", style: TextTheme.of(context).titleLarge),
            const SizedBox(height: 14),
            Text("Please enter the details below to continue", style: TextTheme.of(context).titleMedium),
            const SizedBox(height: 25),
            Form(
              key: _key,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Todo add validator
                      const AppDropMenu(),
                      const SizedBox(width: 6),
                      Expanded(
                        child: AppInput(
                          controller: _phoneController,
                          labelText: "Phone Number",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  AppInput(
                    controller: _passwordController,
                    labelText: "Your Password",
                    isPasswordField: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  ///Todo add Forget password screen nav
                  onTap: () =>
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPasswordView())),
                  child: Text("Forget Password?", style: TextTheme.of(context).labelMedium),
                ),
              ],
            ),
            const SizedBox(height: 40),
            AppButton(
              isChildIcon: false,
              onPressed: () async {
                if (_key.currentState!.validate()) {
                  final data = {
                    "countryCode": _countryCodeController.text,
                    "phoneNumber": _phoneController.text,
                    "password": _passwordController.text,
                  };
                  final response = await DioHelper().postData(endpoint: ApiConstant.login, data: data);
                  if (context.mounted) {
                    _reqValidation(context, response);
                  }
                }
              },
              text: "Login",
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsetsGeometry.symmetric(vertical: 20),
        child: GestureDetector(
          onTap: () =>
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterView())),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Don’t have an account?",
                  style: TextTheme.of(
                    context,
                  ).titleMedium?.copyWith(fontSize: 18, color: ColorScheme.of(context).secondary),
                ),
                const WidgetSpan(child: SizedBox(width: 10)),
                TextSpan(text: "Register", style: TextTheme.of(context).labelMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
