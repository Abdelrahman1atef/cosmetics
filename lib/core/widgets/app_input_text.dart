import 'package:flutter/material.dart';

import 'app_image.dart';

class AppInputText extends StatefulWidget {
  const AppInputText({
    super.key,
    this.labelText,
    this.isPasswordField = false,
    this.controller,
    this.validator,
    this.hintText,
    this.title,
    this.haveTitle,
    this.padding,
    this.obscuringCharacter = '•',
    this.borderRadius,
    this.fillColor,
    this.borderWidth,
    this.keyboardType,
    this.maxLines = 1,
    this.borderColor,
    this.icon,
    this.suffixIcon,
    this.filled,
    this.onTap,
    this.onChanged, this.textStyle,
  });

  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final EdgeInsetsGeometry? padding;
  final TextInputType? keyboardType;
  final Color? fillColor, borderColor;
  final bool isPasswordField;
  final bool? haveTitle, filled;
  final int maxLines;
  final double? borderRadius, borderWidth;
  final String obscuringCharacter;
  final String? title, labelText, hintText;
  final Widget? icon, suffixIcon;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final TextStyle? textStyle;


  @override
  State<AppInputText> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<AppInputText> {
  bool passwordIsHidden = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = Theme.of(context).textTheme;
    double borderWidth = 1;
    double borderRadius = 22;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.haveTitle ?? false) ...{
          Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 13),
            child: Text(widget.title ?? "", style: theme.textTheme.titleSmall),
          ),
          const SizedBox(height: 10),
        },
        InputDecorationTheme(
          labelStyle: theme.textTheme.titleMedium?.copyWith(color: const Color(0xFF727272)),
          filled: widget.filled ?? true,
          fillColor: widget.fillColor ?? theme.colorScheme.surface,
          floatingLabelStyle: theme.textTheme.titleMedium?.copyWith(color: const Color(0xFF727272), fontSize: 20),
          hintMaxLines: 1,
          hintStyle: theme.textTheme.labelLarge,
          contentPadding: widget.padding ?? const EdgeInsetsGeometry.symmetric(vertical: 20, horizontal: 10),

          focusedBorder: OutlineInputBorder(
            gapPadding: 16,
            borderRadius: BorderRadius.circular(widget.borderRadius ?? borderRadius),
            borderSide: BorderSide(
              color: widget.borderColor ?? theme.colorScheme.outline,
              width: widget.borderWidth ?? borderWidth,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            gapPadding: 16,
            borderRadius: BorderRadius.circular(widget.borderRadius ?? borderRadius),
            borderSide: BorderSide(
              color: widget.borderColor ?? theme.colorScheme.outline,
              width: widget.borderWidth ?? borderWidth,
            ),
          ),
          errorMaxLines: 2,
          errorStyle: textTheme.displaySmall,
          errorBorder: OutlineInputBorder(
            gapPadding: 16,
            borderRadius: BorderRadius.circular(widget.borderRadius ?? borderRadius),
            borderSide: BorderSide(color: theme.colorScheme.error, width: widget.borderWidth ?? borderWidth),
          ),
          focusedErrorBorder: OutlineInputBorder(
            gapPadding: 16,
            borderRadius: BorderRadius.circular(widget.borderRadius ?? borderRadius),
            borderSide: BorderSide(color: theme.colorScheme.error, width: widget.borderWidth ?? borderWidth),
          ),

          child: TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            style: theme.textTheme.displayMedium?.merge(widget.textStyle),
            obscureText: widget.isPasswordField ? passwordIsHidden : false,
            obscuringCharacter: widget.obscuringCharacter,
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              labelText: widget.labelText,
              hintText: widget.hintText ?? "",
              prefixIcon: widget.icon,
              prefixIconConstraints: const BoxConstraints(minWidth: 50),
              suffixIconConstraints: const BoxConstraints(minWidth: 50),
              suffixIcon:
                  widget.suffixIcon ??
                  (widget.isPasswordField
                      ? passwordIsHidden
                            ? IconButton(
                                icon: const AppImage(image: "visibility_off.png"),
                                onPressed: () {
                                  setState(() {
                                    passwordIsHidden = false;
                                  });
                                },
                              )
                            : IconButton(
                                icon: const AppImage(image: "visibility.svg"),
                                onPressed: () {
                                  setState(() {
                                    passwordIsHidden = true;
                                  });
                                },
                              )
                      : null),
            ),
            onChanged: widget.onChanged,
            onTap: widget.onTap,
          ),
        ),
      ],
    );
  }
}
