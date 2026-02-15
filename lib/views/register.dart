import 'package:cosmetics/core/logic/helper_method.dart';
import 'package:cosmetics/views/home/view.dart';
import 'package:cosmetics/views/login.dart';
import 'package:cosmetics/views/verify_code.dart';
import 'package:flutter/material.dart';
import '../core/logic/cash_helper.dart';
import '../core/network/dio_helper.dart';
import '../core/widgets/app_image.dart';
import '../core/widgets/app_button.dart';
import '../core/widgets/app_drop_menu.dart';
import '../core/widgets/app_input.dart';
import '../core/widgets/my_app_bar.dart';
import '../features/auth/register_model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key, this.isProfileUpdate = false});

  final bool isProfileUpdate;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  var _selectedCountryCode = CountryCodeModel();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.isProfileUpdate) {
      final user = CashHelper.getUserData();
      _nameController.text = user!.username;
      _emailController.text = user.email;
      _phoneController.text = user.phoneNumber;
    }
    super.initState();
  }

  void _req(BuildContext context, RegisterRequestModel data) async {
    final CustomResponse response;
    if (widget.isProfileUpdate) {
      response = await DioHelper.putData(endpoint: "api/Auth/profile", data: data.toJson());
    } else {
      response = await DioHelper.postData(endpoint: "api/Auth/register", data: data.toJson());
    }
    if (!context.mounted) return;
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
    if (widget.isProfileUpdate) {
      await CashHelper.setData("username", _nameController.text);
      await CashHelper.setData("email", _emailController.text);
      await CashHelper.setData("phoneNumber", _phoneController.text);
      await CashHelper.setData("countryCode", _selectedCountryCode.code);
      showMsg(response.msg);
      goto(const HomeView(), canPop: false);
    } else {
      goto(
        VerifyCodeView(isRegister: true, phoneNumber: _phoneController.text, countryCode: _selectedCountryCode.code),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.isProfileUpdate ? "Update Profile" : "Create Account";
    final btnText = widget.isProfileUpdate ? "Done" : "Next";
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: widget.isProfileUpdate
          ? null
          : Padding(
        padding: const EdgeInsetsGeometry.symmetric(vertical: 20),
        child: GestureDetector(
          onTap: () => goto( const LoginView()),
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
      appBar: const MyAppBar(haveTitle: false, haveSearchBar: false, canPop: true),
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
            Text(title, style: TextTheme.of(context).titleLarge),
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

                      if (_validateEmail(value) == false) {
                        return 'Please enter a valid Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppDropMenu(
                        value: _selectedCountryCode,
                        onChanged: (value) {
                          setState(() {
                            _selectedCountryCode = value as CountryCodeModel;
                          });
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
                            switch (_selectedCountryCode.code) {
                              case "+20":
                                if (value.length <= 10) {
                                  return 'Phone number of ${_selectedCountryCode.name} more than 10 digits';
                                }
                                if (value.length > 11) {
                                  return 'Phone number of ${_selectedCountryCode.name} less than 11 digits';
                                }
                                break;

                              default:
                                if (value.length <= 9) {
                                  return 'Phone number of ${_selectedCountryCode.name} more than 9 digits';
                                }
                                if (value.length > 10) {
                                  return "Phone number of ${_selectedCountryCode.name} less than 10 digits";
                                }
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (!widget.isProfileUpdate) ...[
                    AppInput(
                      controller: _passwordController,
                      labelText: "Create your password",
                      isPasswordField: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters long.';
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
                    countryCode: _selectedCountryCode.code,
                    phoneNumber: _phoneController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  _req(context, data);
                }
              },
              text: btnText,
            ),
          ],
        ),
      ),
    );
  }

  bool _validateEmail(String value) {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(value);
  }
}
