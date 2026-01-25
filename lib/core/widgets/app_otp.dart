import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AppOtp extends StatelessWidget {
  const AppOtp({
    super.key,
    required this.length,
    this.textInputType,
    this.fieldWidth = 70,
    this.fieldHeight = 70,
    this.enableHint,
  });

  final int length;
  final TextInputType? textInputType;
  final double? fieldWidth;
  final double? fieldHeight;
  final bool? enableHint;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PinCodeTextField(
      appContext: context,
      length: length,
      keyboardType: textInputType ?? TextInputType.number,
      textStyle: theme.textTheme.titleLarge,
      animationType: AnimationType.fade,
      hintCharacter: enableHint ?? true ? "_" : null,
      hintStyle: enableHint ?? true
          ? theme.textTheme.titleMedium?.copyWith(
              fontSize: 25,
              fontVariations: <FontVariation>[const FontVariation('wght', 700)],
            )
          : null,
      enableActiveFill: true,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      cursorColor: theme.hintColor,
      cursorWidth: 3,
      pinTheme: PinTheme(
        fieldWidth: fieldWidth,
        fieldHeight: fieldHeight,
        borderRadius: BorderRadius.circular(16),
        shape: PinCodeFieldShape.box,
        selectedFillColor:theme.colorScheme.secondary,
        activeFillColor: theme.colorScheme.secondary,
        inactiveFillColor: theme.colorScheme.secondary,
        inactiveColor: theme.colorScheme.secondary,
        selectedColor: theme.primaryColor,
        activeColor: theme.primaryColor,
      ),
    );
  }
}
