import 'package:cosmetics/core/logic/helper_method.dart';
import 'package:cosmetics/core/widgets/app_button.dart';
import 'package:cosmetics/views/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../core/network/dio_helper.dart';
import '../core/widgets/app_image.dart';
import 'create_password.dart';

class VerifyCodeView extends StatefulWidget {
  const VerifyCodeView({super.key, required this.isRegister, required this.phoneNumber, required this.countryCode});

  final bool isRegister;
  final String countryCode;
  final String phoneNumber;

  @override
  State<VerifyCodeView> createState() => _VerifyCodeViewState();
}

class _VerifyCodeViewState extends State<VerifyCodeView> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String get formatedPhoneNumber {
    if (widget.phoneNumber.startsWith("0")) {
      return widget.phoneNumber.substring(1);
    }
    return widget.phoneNumber;
  }

  void _req(BuildContext context, Map<String, dynamic> data) async {
    final response = await DioHelper.postData(endpoint: "api/Auth/verify-otp", data: data);

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
    widget.isRegister
        ? showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) => PopScope(
                canPop: false,
                child: SuccessDialog(isRegister: widget.isRegister)),
          )
        : goto(CreatePasswordView(countryCode: widget.countryCode, phoneNumber: widget.phoneNumber));
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
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppImage(image: "app_icon.svg", width: 100),
              const SizedBox(height: 40),
              Text("Verify Code", style: TextTheme.of(context).titleLarge),
              const SizedBox(height: 40),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "We just sent a 4-digit verification code to\n",
                      style: TextTheme.of(context).titleMedium,
                    ),
                    TextSpan(
                      text: "${widget.countryCode} $formatedPhoneNumber",
                      style: TextTheme.of(context).displayMedium,
                    ),
                    TextSpan(
                      text: ". Enter the code in the box below to continue.",
                      style: TextTheme.of(context).titleMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text("Edit the number", style: TextTheme.of(context).labelMedium),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsetsGeometry.symmetric(horizontal: 60),
                child: PinCodeTextField(
                  controller: _controller,
                  appContext: context,
                  length: 4,
                  textStyle: TextTheme.of(context).displayMedium?.copyWith(fontSize: 20, fontWeight: FontWeight.w900),
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  hintCharacter: "–",
                  hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 25,
                    fontVariations: <FontVariation>[const FontVariation('wght', 700)],
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  cursorColor: Theme.of(context).hintColor,
                  cursorWidth: 3,
                  pinTheme: PinTheme(
                    fieldWidth: 60,
                    fieldHeight: 60,
                    borderRadius: BorderRadius.circular(12),
                    shape: PinCodeFieldShape.box,
                    inactiveColor: Theme.of(context).hintColor,
                    selectedColor: Theme.of(context).colorScheme.primary,
                    activeColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 50),

              ///todo add timer for resend code
              GestureDetector(
                onTap: () {},
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Didn’t receive a code? ",
                        style: TextTheme.of(
                          context,
                        ).titleMedium?.copyWith(fontSize: 18, color: ColorScheme.of(context).secondary),
                      ),
                      TextSpan(
                        text: " Resend",
                        style: TextTheme.of(
                          context,
                        ).labelMedium?.copyWith(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.7)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              AppButton(
                onPressed: () async {
                  final data = {
                    "countryCode": widget.countryCode,
                    "phoneNumber": widget.phoneNumber,
                    "otpCode": _controller.text,
                  };
                  if (context.mounted) {
                    _req(context, data);
                  }
                },
                text: "Done",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
