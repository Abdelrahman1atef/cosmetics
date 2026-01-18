// ignore_for_file: inference_failure_on_instance_creation
import 'package:cosmetics/views/login.dart';
import 'package:cosmetics/views/verify_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/widgets/app_image.dart';
import '../core/widgets/app_button.dart';
import '../core/widgets/app_drop_menu.dart';
import '../core/widgets/app_input.dart';
import '../features/auth/register/cubit.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.isLoading) {
          showDialog<void>(
            context: context,
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        }
        if (state.errorMessage != null) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                duration: const Duration(seconds: 3),
                backgroundColor: Theme.of(context).colorScheme.secondary,
                content: Text(state.errorMessage!,style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Colors.white,
                ),)),
          );
          return;
        }
        if (state.registerResponseModel != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  VerifyCodeView(
                isRegister: true,
                phoneNumber: "${_countryCodeController.text} ${_phoneController.text}",
              ),
            ),
          );
        }
      },
      child: Scaffold(
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

                ///Todo add validator to form and send api call to nav
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    final RegisterRequestModel reqModel = RegisterRequestModel(
                      username: _nameController.text,
                      countryCode: _countryCodeController.text,
                      phoneNumber: _phoneController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    context.read<RegisterCubit>().register(reqModel);

                    return;
                  }
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
              MaterialPageRoute(builder: (context) => const LoginView()),
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
      ),
    );
  }
}
