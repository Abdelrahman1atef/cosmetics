import 'package:cosmetics/core/widgets/app_Image.dart';
import 'package:cosmetics/views/check_out.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.haveTitle,
    required this.haveSearchBar,
    this.title,
    this.haveAction,
  });

  final bool haveTitle, haveSearchBar;
  final bool? haveAction;
  final String? title;

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight + (haveSearchBar && haveTitle ? kToolbarHeight : 25),
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      leadingWidth: 50,
      leading: Navigator.canPop(context)
          ? Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 10),
            child: CircleAvatar(
            maxRadius: 20,
            backgroundColor: Theme.of(context).hintColor.withValues(
              alpha: 0.3
            ),
            child: const AppImage(image: "arrow_back.svg")),
          )
          : null,
      centerTitle: true,
      title: haveTitle
          ? Text(
              title ?? "",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontSize: 30),
            )
          : null,
      actionsPadding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
      actions: haveAction ?? false
          ? [
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CheckOutView()),
                ),
                child: const AppImage(image: "check_out.svg", width: 30),
              ),
            ]
          : null,
      bottom: haveSearchBar
          ? PreferredSize(
              preferredSize: preferredSize,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchBarTheme(
                  data: Theme.of(context).searchBarTheme,
                  child: SearchBar(
                    hintText: "Search",
                    hintStyle: WidgetStatePropertyAll(
                      Theme.of(context).textTheme.titleSmall,
                    ),
                    trailing: const [AppImage(image: "search.svg")],
                    textStyle: WidgetStatePropertyAll(
                      Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
