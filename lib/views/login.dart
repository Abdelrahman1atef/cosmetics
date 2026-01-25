// ignore_for_file: inference_failure_on_instance_creation

import 'package:cosmetics/core/widgets/app_button.dart';
import 'package:cosmetics/core/widgets/app_drop_menu.dart';
import 'package:cosmetics/views/forget_password.dart';
import 'package:cosmetics/views/register.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/logic/helper_method.dart';
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

  void _req(BuildContext context,Map<String,dynamic> data)async {
    final response = await DioHelper.postData(endpoint: "api/Auth/login", data: data);

    showDialog<void>(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    if (!response.isSuccess) {
      Navigator.pop(context);
      final msg = response.data['message'];
      showMsg(msg);
      return;
    }
    Navigator.pop(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", response.data["token"]);
    goto(const HomeView(),canPop: false);
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
                  if (context.mounted) {
                    _req(context,data);
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
