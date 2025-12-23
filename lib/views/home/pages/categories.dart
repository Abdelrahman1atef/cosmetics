import 'package:cosmetics/core/widgets/app_Image.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/app_bar.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const CustomAppBar(
        haveSearchBar: true,
        haveTitle: true,
        title: "Categories",
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 10),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsetsGeometry.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(16),

                        child: AppImage(image: category.image,fit: BoxFit.cover,width: 80,)),
                    const SizedBox(width: 20),
                    Text(
                      category.title,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                const AppImage(image: "arrow-right.svg"),
              ],
            ),
          );
        },
      ),
    );
  }
}

final categories = [
  _CategoryItem(title: "Bundles", image: "cat_bundles.png"),
  _CategoryItem(title: "Perfumes", image: "cat_perfumes.png"),
  _CategoryItem(title: "Makeup", image: "cat_makeup.png"),
  _CategoryItem(title: "Skin Care", image: "cat_skin_care.png"),
  _CategoryItem(title: "Gifts", image: "cat_gifts.jpg"),
];

class _CategoryItem {
  final String title;
  final String image;

  _CategoryItem({required this.title, required this.image});
}
