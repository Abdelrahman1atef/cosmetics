import 'dart:math';

import 'package:cosmetics/core/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/logic/helper_method.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/widgets/my_app_bar.dart';
import 'cart/view.dart';

class _CategoriesModel {
  late final int id;
  late final String title;
  late final String imageUrl;

  _CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    title = json['title_en'] ?? json['title_ar'] ?? json['title'] ?? "";
    imageUrl = json['image_url'] ?? json['imageUrl'] ?? "";
  }
}

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late List<_CategoriesModel> _categories;
  DataStates _categoriesStates = DataStates.uninitialized;

  Future<void> _productsReq() async {
    _categoriesStates = DataStates.loading;
    setState(() {});
    final response = await DioHelper.getData("api/Categories");
    if (response.isSuccess) {
    _categoriesStates = DataStates.loaded;
      _categories = (response.data as List).map((e) => _CategoriesModel.fromJson(e)).toList();
    } else {
      _categoriesStates = DataStates.error;
      showMsg(response.msg);
      _categories = [];
    }
     setState(() {});
  }

  @override
  void initState() {
    _productsReq();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const MyAppBar(haveSearchBar: true, haveTitle: true, title: "Categories"),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 10),
        itemCount: _categoriesStates != DataStates.loaded ? 8 : _categories.length,
        itemBuilder: (context, index) {
          late _CategoriesModel category;
          if (_categoriesStates == DataStates.loaded) {
           category = _categories[index];
          }
          if (_categoriesStates == DataStates.loading) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child:  Container(
                height: 110,
                color: Colors.grey.shade300,),
            );
          } else {
            return Padding(
              padding: const EdgeInsetsGeometry.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: AppImage(
                          image: imageList[Random().nextInt(imageList.length)],
                          // image: category.imageUrl,
                          fit: BoxFit.cover,
                          height: 80,
                          width: 80,
                          errorBuilder: (context, error, stackTrace) => const AppImage(image: "cat_bundles.png"),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(category.title, style: Theme.of(context).textTheme.displayMedium),
                    ],
                  ),
                  const AppImage(image: "arrow_right.svg"),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
