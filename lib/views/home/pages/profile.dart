import 'package:flutter/material.dart';

import '../../../core/widgets/app_Image.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
                  begin:  AlignmentGeometry.topCenter,
                  end:  AlignmentGeometry.bottomCenter,
                  colors: [
                    Theme.of(
                      context,
                    ).colorScheme.secondary.withValues(alpha: 0.7),
                    const Color(0xFFECA4C5),
                  ],
                ),
              ),

            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 120,
            child: Column(
              children: [
                ///todo put user info here
                const AppImage(image: "girl.png", width: 120),
                const SizedBox(height: 20),
                Text(
                  "Sara Samer Talaat",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 20),
                Column(
                  children: profileActions
                      .map(
                        (action) => Padding(
                          padding: const EdgeInsetsGeometry.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
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
                                        ? Theme.of(
                                      context,
                                    ).textTheme.displayMedium
                                        :Theme.of(
                                      context,
                                    ).textTheme.displayMedium?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.error,
                                    ) ,
                                  ),
                                ],
                              ),
                              action.hasArrow ?? false
                                  ? const AppImage(image: "arrow-right.svg")
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
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
  ),
];

class _ProfileAction {
  final AppImage icon;
  final String title;
  final bool? hasArrow;

  _ProfileAction({
    required this.icon,
    required this.title,
    this.hasArrow = true,
  });
}

