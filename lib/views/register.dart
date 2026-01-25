// ignore_for_file: inference_failure_on_instance_creation
import 'package:cosmetics/core/logic/helper_method.dart';
import 'package:cosmetics/views/login.dart';
import 'package:cosmetics/views/verify_code.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../core/network/dio_helper.dart';
import '../core/widgets/app_image.dart';
import '../core/widgets/app_button.dart';
import '../core/widgets/app_drop_menu.dart';
import '../core/widgets/app_input.dart';
import '../features/auth/register/model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _countryCodeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _countryCodeController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _req(BuildContext context, RegisterRequestModel data) async {
    final response = await DioHelper.postData(endpoint: "api/Auth/register", data: data.toJson());

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
    goto(
      VerifyCodeView(isRegister: true, phoneNumber: _phoneController.text, countryCode: _countryCodeController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsetsGeometry.symmetric(vertical: 20),
        child: GestureDetector(
          onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginView())),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Have an account?",
                  style: TextTheme.of(
                    context,
                  ).titleMedium?.copyWith(fontSize: 18, color: ColorScheme.of(context).secondary),
                ),
                const WidgetSpan(child: SizedBox(width: 10)),
                TextSpan(text: " login", style: TextTheme.of(context).labelMedium),
              ],
            ),
          ),
        ),
      ),

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
            const SizedBox(height: 40),
            Text("Create Account", style: TextTheme.of(context).titleLarge),
            const SizedBox(height: 80),
            Form(
              key: _key,
              child: Column(
                children: [
                  AppInput(
                    labelText: "Your Name",
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  AppInput(
                    labelText: "Email",
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Todo add validator to DropdownMenu
                      AppDropMenu(
                        onChanged: (value) {
                          _countryCodeController.text = value!;
                        },
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: AppInput(
                          labelText: "Phone Number",
                          controller: _phoneController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            if (value.length <= 10) {
                              return 'Please enter a valid phone number more than 10 digits';
                            }
                            if (value.length > 11) {
                              return 'Please enter a valid phone number less than 11 digits';
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
                    labelText: "Create your password",
                    isPasswordField: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 5) {
                        return 'Please enter a valid password more than 5 characters';
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
                        return 'Please confirm your password';
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
            const SizedBox(height: 50),
            AppButton(
              isChildIcon: false,
              onPressed: () async {
                if (_key.currentState!.validate()) {
                  final RegisterRequestModel data = RegisterRequestModel(
                    username: _nameController.text,
                    countryCode: _countryCodeController.text,
                    phoneNumber: _phoneController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  _req(context, data);
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
