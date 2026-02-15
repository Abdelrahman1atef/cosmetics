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
  var _selectedCountryCode = CountryCodeModel();
  DataStates _state = DataStates.uninitialized;

  void _req(BuildContext context, dynamic data) async {
    _state = DataStates.loading;
    setState(() {});
    final response = await DioHelper.postData(endpoint: "api/Auth/forgot-password", data: data);
    if (response.isSuccess) {
      _state = DataStates.loaded;
      goto(
        VerifyCodeView(isRegister: false, countryCode: _selectedCountryCode.code, phoneNumber: _phoneController.text),
      );
    } else {
      _state = DataStates.error;
      final msg = response.data['message'];
      showMsg(msg);
      return;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
              onPressed: _state == DataStates.loading
                  ? null
                  : () {
                      if (_key.currentState!.validate()) {
                        final data = {"countryCode": _selectedCountryCode.code, "phoneNumber": _phoneController.text};
                        if (context.mounted) {
                          _req(context, data);
                        }
                      }
                    },
              widget: _state == DataStates.loading
                  ? const CircularProgressIndicator(color: Colors.white,constraints: BoxConstraints(minHeight: 25,minWidth: 25),)
                  : Text("Next", style: textTheme.bodyMedium),
            ),
          ],
        ),
      ),
    );
  }
}
