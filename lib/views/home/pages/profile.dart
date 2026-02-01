import 'package:cosmetics/views/register.dart';
import 'package:flutter/material.dart';

import '../../../core/logic/cash_helper.dart';
import '../../../core/logic/helper_method.dart';
import '../../../core/widgets/app_image.dart';
import '../../../features/auth/login_model.dart';
import '../../login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User user;

  @override
  void initState() {
    user = CashHelper.getUserData()!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentGeometry.center,
        children: [
          Positioned(
            top: -20,
            left: 0,
            right: 0,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentGeometry.topCenter,
                  end: AlignmentGeometry.bottomCenter,
                  colors: [Theme.of(context).colorScheme.secondary.withValues(alpha: 0.7), const Color(0xFFECA4C5)],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 120,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(100),
                    child: AppImage(
                      image: user.profilePhotoUrl,
                      width: 120,
                      height: 120,
                      errorBuilder: (context, error, stackTrace) => const Text("404"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(user.username, style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(height: 20),
                  Column(
                    children: profileActions
                        .map(
                          (action) => InkWell(
                            onTap: action.action ?? () {},
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      action.icon,
                                      const SizedBox(width: 10),
                                      Text(
                                        action.title,
                                        style: action.hasArrow ?? false
                                            ? Theme.of(context).textTheme.displayMedium
                                            : Theme.of(context).textTheme.displayMedium?.copyWith(
                                                color: Theme.of(context).colorScheme.error,
                                              ),
                                      ),
                                    ],
                                  ),
                                  action.hasArrow ?? false ? const AppImage(image: "arrow_right.svg") : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final profileActions = [
  _ProfileAction(
    icon: const AppImage(image: "edit.svg"),
    title: "Edit Info",
    action: () {
      goto(const RegisterView(isProfileUpdate: true), canPop: true);
    },
  ),
  _ProfileAction(
    icon: const AppImage(image: "history.svg"),
    title: "Order History",
  ),
  _ProfileAction(
    icon: const AppImage(image: "wallet.svg"),
    title: "Wallet",
  ),
  _ProfileAction(
    icon: const AppImage(image: "settings.svg"),
    title: "Settings",
  ),
  _ProfileAction(
    icon: const AppImage(image: "voucher.svg"),
    title: "Voucher",
  ),
  _ProfileAction(
    icon: const AppImage(image: "logout.svg"),
    title: "Logout",
    hasArrow: false,
    action: () async {
      CashHelper.removeUserDate();
      goto(const LoginView(), canPop: false);
    },
  ),
];

class _ProfileAction {
  final AppImage icon;
  final String title;
  final bool? hasArrow;
  final void Function()? action;

  _ProfileAction({required this.icon, required this.title, this.hasArrow = true, this.action});
}
