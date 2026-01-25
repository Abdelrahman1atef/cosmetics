import 'package:cosmetics/core/logic/helper_method.dart';
import 'package:cosmetics/views/verify_code.dart';
import 'package:flutter/material.dart';

import '../core/network/dio_helper.dart';
import '../core/widgets/app_image.dart';
import '../core/widgets/app_button.dart';
import '../core/widgets/app_drop_menu.dart';
import '../core/widgets/app_input.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _key = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _countryCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _countryCodeController.text = "+20";
  }

  void _req(BuildContext context, dynamic data) async {
    final response = await DioHelper.postData(endpoint: "api/Auth/forgot-password", data: data);

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
    goto(VerifyCodeView(
      isRegister: false,
      countryCode: _countryCodeController.text,
      phoneNumber: _phoneController.text,
    ));
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
            Text("Forget Password", style: TextTheme.of(context).titleLarge),
            const SizedBox(height: 60),
            Text(
              "Please enter your phone number below to recovery your password.",
              style: TextTheme.of(context).titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Form(
              key: _key,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Todo style dropdown menu
                      ///Todo add validator
                      AppDropMenu(
                        onChanged: (value) => setState(() {
                          _countryCodeController.text = value ?? "+20";
                        }),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        ///Todo add validator
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
                ],
              ),
            ),
            const SizedBox(height: 60),
            AppButton(
              onPressed: ()  {
                if (_key.currentState!.validate()) {
                  final data = {"countryCode": _countryCodeController.text, "phoneNumber": _phoneController.text};
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
