import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app_Image.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    //
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsetsGeometry.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadiusGeometry.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),

                  child: AppImage(image: image, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsetsGeometry.all(8),
                    margin: const EdgeInsetsGeometry.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusGeometry.circular(8),
                    ),
                    child: AppImage(image: "add_to_cart.svg")
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "Product Name",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 10),
            Text(
              "\$44.99",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,

              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontVariations: <FontVariation>[
                  const FontVariation('wght', 700),
                ],
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
