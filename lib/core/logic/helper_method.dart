import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final navKey = GlobalKey<NavigatorState>();
final context = navKey.currentContext;

void goto(Widget page, {bool canPop = true, int? delayInMilliSeconds}) {
  void action() {
    Navigator.pushAndRemoveUntil(context!, MaterialPageRoute<void>(builder: (context) => page), (route) => canPop);
  }

  if (delayInMilliSeconds != null) {
    Future.delayed(Duration(milliseconds: delayInMilliSeconds), action);
  } else {
    action();
  }
}

void showMsg(String? msg, {bool isError = false}) {
  if (msg == null) return;
  ScaffoldMessenger.of(context!).showSnackBar(
    SnackBar(
      content: Text(msg, style: Theme.of(context!).textTheme.displaySmall?.copyWith(color: Colors.white)),
    ),
  );
}
