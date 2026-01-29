import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../features/home/product_model.dart';
import 'app_image.dart';

class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.product});

  final ProductModel product;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Center(
                      child: AppImage(
                        image: product.imageUrl,
                        fit: BoxFit.cover,
                        height: 200,
                        width: 200,
                        errorBuilder: (context, error, stackTrace) => const AppImage(
                          image:
                              "https://media.istockphoto.com/id/1399588872/vector/corrupted-pixel-file-icon-damage-document-symbol-sign-broken-data-vector.jpg?s=612x612&w=0&k=20&c=ffG6gVLUPfxZkTwjeqdxD67LWd8R1pQTIyIVUi-Igx0=",
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsetsGeometry.all(8),
                      margin: const EdgeInsetsGeometry.all(8),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadiusGeometry.circular(8)),
                      child: AppImage(image: "add_to_cart.svg"),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(product.name, style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(height: 10),
            Text(
              "\$${product.price}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontVariations: <FontVariation>[const FontVariation('wght', 700)],
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingProductWidget extends StatelessWidget {
  const LoadingProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: double.infinity,
                // height: 150,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Title placeholder
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 14,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
            ),
          ),

          const SizedBox(height: 8),

          // Price placeholder
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 14,
              width: 80,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
            ),
          ),
        ],
      ),
    );
  }
}
