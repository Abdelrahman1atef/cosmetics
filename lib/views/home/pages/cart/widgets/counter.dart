import 'package:cosmetics/core/widgets/app_image.dart';
import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int count=1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(12),
        border: Border.all(
          color: Theme.of(context).hintColor,
          width: 2
        )
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {if(count>1){
              setState(() {

                count--;

              });
                }
            },
            child: Container(
                width: 20,
                height: 40,
                margin: const EdgeInsetsGeometry.symmetric(horizontal: 15),
                child: const AppImage(image: "minus.svg",fit: BoxFit.none,)),),
          const SizedBox(width: 10),
           Text("$count",style: Theme.of(context).textTheme.displayMedium,),
          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              setState(() {
                count++;
              });
            },
            child: Container(
                width: 20,
                height: 40,
                margin: const EdgeInsetsGeometry.symmetric(horizontal: 15),
                child: const AppImage(image: "plus.svg",fit: BoxFit.none,)),),
        ],
      ),
    );
  }
}
