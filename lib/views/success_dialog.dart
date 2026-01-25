import 'package:cosmetics/core/logic/helper_method.dart';
import 'package:flutter/material.dart';

import '../core/widgets/app_Image.dart';
import '../core/widgets/app_button.dart';
import 'login.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key, required this.isRegister});
  final bool isRegister;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedSuperellipseBorder(borderRadius: BorderRadiusGeometry.circular(30)),
      constraints: const BoxConstraints(minWidth: 360, minHeight: 343),
      icon: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
        radius: 60,
        child: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.7),
          radius: 50,
          child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            radius: 40,
            child: const AppImage(image: 'done_task.svg'),
          ),
        ),
      ),
      alignment: Alignment.center,
      title: Text(isRegister?"Account Activated!":"Password Created!", style: Theme.of(context).textTheme.displayMedium),
      content: Text(
        "Congratulations! Your account has been successfully ${isRegister?"activated":"created"}",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      actions: [
        AppButton(
          width: 90,
          onPressed: () {
            Navigator.pop(context);
            goto(const LoginView(),canPop: false);
          },
          text: isRegister?"Go to login":"Return to login",
        ),
      ],
    );
  }
}
