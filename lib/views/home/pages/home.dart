import 'dart:math';

import 'package:cosmetics/core/network/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/logic/helper_method.dart';
import '../../../core/widgets/app_Image.dart';
import '../../../core/widgets/my_app_bar.dart';
import '../view.dart';

part '../../../features/home/models.dart';

part '../../../core/widgets/app_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<_ProductModel> _products;
  late List<_SliderModel> _sliders;
  DataStates _productsStates = DataStates.uninitialized;
  DataStates _slidersStates = DataStates.uninitialized;

  Future<void> _productsReq() async {
    _productsStates = DataStates.loading;
    setState(() {});
    final response = await DioHelper.getData("api/Products");
    if (response.isSuccess) {
      _productsStates = DataStates.loaded;
      _products = (response.data as List).map((e) => _ProductModel.fromJson(e)).toList();
    } else {
      _productsStates = DataStates.error;
      showMsg(response.msg);
      _products = [];
    }
    setState(() {});
  }

  Future<void> _slidersReq() async {
    _slidersStates = DataStates.loading;
    setState(() {});
    final response = await DioHelper.getData("api/Sliders");
    if (response.isSuccess) {
      _slidersStates = DataStates.loaded;
      _sliders = (response.data as List).map((e) => _SliderModel.fromJson(e)).toList();
    } else {
      _slidersStates = DataStates.error;
      showMsg(response.msg);
      _products = [];
    }
    setState(() {});
  }

  @override
  void initState() {
    _slidersReq();
    _productsReq();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const MyAppBar(haveSearchBar: true, haveTitle: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _BuildSlider(slidersStates: _slidersStates, sliders: _slidersStates != DataStates.loaded ? [] : _sliders),
              const SizedBox(height: 30),
              _BuildProductsGrid(
                title: "Top rated products",
                productsStates: _productsStates,
                products: _productsStates != DataStates.loaded ? [] : _products,
              ),
              const SizedBox(height: 30),
              _BuildProductsGrid(
                title: "Most ordered Products",
                productsStates: _productsStates,
                products: _productsStates != DataStates.loaded ? [] : _products,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildSlider extends StatelessWidget {
  const _BuildSlider({required this.slidersStates, required this.sliders});

  final DataStates slidersStates;
  final List<_SliderModel> sliders;

  @override
  Widget build(BuildContext context) {
    return slidersStates != DataStates.loaded
        ? SizedBox(
            height: 300,
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(color: Colors.white),
            ),
          )
        : SizedBox(
            height: 320,
            child: PageView.builder(
              itemCount: sliders.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final slider = sliders[index];
                return Stack(
                  alignment: AlignmentGeometry.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(15),
                      child: AppImage(
                        fit: BoxFit.cover,
                        image: slider.imageUrl,
                        errorBuilder: (context, error, stackTrace) =>  AppImage(
                          fit: BoxFit.cover,
                          image:
                          imageList[Random().nextInt(imageList.length)],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.symmetric(vertical: 60),
                      padding: const EdgeInsetsGeometry.symmetric(horizontal: 25),
                      decoration: BoxDecoration(color: const Color(0xFFE9DCD3).withValues(alpha: 0.7)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${slider.discountPercent}% OFF DISCOUNT",
                                    style: Theme.of(context).textTheme.headlineMedium,
                                  ),
                                  Text(
                                    "CUPON CODE : ${slider.couponCode}",
                                    style: Theme.of(context).textTheme.headlineMedium,
                                  ),
                                ],
                              ),
                              const AppImage(image: "offer.svg"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AppImage(image: "offer.svg"),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    slider.descriptionTitle1,
                                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                      fontVariations: <FontVariation>[const FontVariation('wght', 700)],
                                    ),
                                  ),
                                  Text(
                                    slider.descriptionTitle2,
                                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                      fontVariations: <FontVariation>[const FontVariation('wght', 700)],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
  }
}

class _BuildProductsGrid extends StatelessWidget {
  const _BuildProductsGrid({required this.title, required this.productsStates, required this.products});

  final String title;

  final DataStates productsStates;
  final List<_ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.displayLarge),
        const SizedBox(height: 30),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 176 / 237,
          ),
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: productsStates != DataStates.loaded ? 4 : products.length,
          itemBuilder: (context, index) =>
              productsStates != DataStates.loaded ? const _LoadingProductWidget() : _AppCard(product: products[index]),
        ),
      ],
    );
  }
}
