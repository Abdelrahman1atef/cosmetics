import 'package:cosmetics/views/verify_code.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../core/network/api_constant.dart';
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
      final data = response.data['message'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          content: Text(data, style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white)),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => VerifyCodeView(
            isRegister: false,
            countryCode: _countryCodeController.text,
            phoneNumber: _phoneController.text,
          ),
        ),
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
                        child: AppInput(controller: _phoneController, labelText: "Phone Number",validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;

                        },),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
            AppButton(
              onPressed: () async{
                if(_key.currentState!.validate()){
                  final data = {
                    "countryCode": _countryCodeController.text,
                    "phoneNumber": _phoneController.text,
                  };
                  final response = await DioHelper().postData(endpoint: ApiConstant.forgotPassword, data: data);
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
