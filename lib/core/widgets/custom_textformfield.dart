import 'package:flutter/material.dart';


class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.isPasswordField = false, this.controller, this.validator,
  });
  final TextEditingController? controller;
  final bool isPasswordField;
  final String labelText;
  final FormFieldValidator<String>? validator;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool passwordIsHidden = true;

  @override
  Widget build(BuildContext context) {
    return InputDecorationTheme(
      //todo review this
      // data:Theme.of(context).inputDecorationTheme,
      labelStyle: TextTheme.of(context).titleMedium,
      floatingLabelStyle: TextTheme.of(context).titleMedium?.copyWith(fontSize: 25),
      focusedBorder: OutlineInputBorder(
        gapPadding: 16,
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide(
          color: Theme.of(context).hintColor,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        gapPadding: 16,
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide(
          color: Theme.of(context).hintColor,
          width: 2,
        ),
      ),
      errorMaxLines: 2,
      errorStyle: TextTheme.of(context).displaySmall,
      errorBorder: OutlineInputBorder(
        gapPadding: 16,
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.error,
          width: 2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        gapPadding: 16,
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.error,
          width: 2,
        ),
      ),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        style: TextTheme.of(context).titleMedium?.copyWith(
          color: ColorScheme.of(context).secondary,
        ),
        obscureText: widget.isPasswordField ? passwordIsHidden : false,
        obscuringCharacter:"*",
        decoration: InputDecoration(
          labelText: widget.labelText,
          suffixIcon: widget.isPasswordField
              ? passwordIsHidden
                    ? IconButton(
                        icon: const Icon(Icons.visibility_outlined),
                        color: Theme.of(context).hintColor,
                        onPressed: () {
                          setState(() {
                            passwordIsHidden = false;
                          });
                        },
                      )
                    : IconButton(
                        icon: const Icon(Icons.visibility_off_outlined),
                        color: Theme.of(context).hintColor,
                        onPressed: () {
                          setState(() {
                            passwordIsHidden = true;
                          });
                        },
                      )
              : null,

        ),
      ),
    );
  }
}
