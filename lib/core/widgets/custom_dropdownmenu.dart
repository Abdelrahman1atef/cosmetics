import 'package:flutter/material.dart';


class CustomDropdownMenu extends StatelessWidget {
  const CustomDropdownMenu({super.key,  this.onChanged});
  final ValueChanged<String?>? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 20,vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(width: 2,
            color: Theme.of(context).hintColor),
        borderRadius: BorderRadius.circular(13)
      ),
      child: DropdownButton(

        onChanged: onChanged,
        value: "+20",
        borderRadius: BorderRadius.circular(13),
        elevation: 0,
        icon: const Icon(Icons.keyboard_arrow_down_rounded),

        style: TextTheme.of(context).titleMedium?.copyWith(
          fontSize: 18,
          color: ColorScheme.of(context).secondary,
        ),
        items: const [
          DropdownMenuItem(value: "+20", child: Text('+20')),
          DropdownMenuItem(value: "+21", child: Text('+21')),
        ],
      ),
    );
  }
}
