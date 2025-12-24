import 'package:cosmetics/core/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class CheckOutView extends StatelessWidget {
  const CheckOutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(haveTitle: true, haveSearchBar: false,title: "Checkout",),
    );
  }
}
