import 'package:cosmetics/core/network/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/logic/helper_method.dart';
import '../../../core/widgets/app_image.dart';
import '../../../core/widgets/my_app_bar.dart';
import '../../../core/widgets/app_card.dart';
import '../../../features/home/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<ProductModel> _products;
  late List<SliderModel> _sliders;
  DataStates _productsDataStates = DataStates.uninitialized;
  DataStates _slidersDataStates = DataStates.uninitialized;

  Future<void> _productsReq() async {
    _productsDataStates = DataStates.loading;
    setState(() {});
    final response = await DioHelper.getData("api/Products");
    if (response.isSuccess) {
      _productsDataStates = DataStates.loaded;
      _products = (response.data as List).map((e) => ProductModel.fromJson(e)).toList();
    } else {
      _productsDataStates = DataStates.error;
      showMsg(response.msg);
      _products = [];
    }
    setState(() {});
  }
  Future<void> _slidersReq() async {
    _slidersDataStates = DataStates.loading;
    setState(() {});
    final response = await DioHelper.getData("api/Sliders");
    if (response.isSuccess) {
      _slidersDataStates = DataStates.loaded;
      _products = (response.data as List).map((e) => ProductModel.fromJson(e)).toList();
    } else {
      _slidersDataStates = DataStates.error;
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
              const _BuildSlider(),
              const SizedBox(height: 30),
              _BuildProductsGrid(title: "Top rated products", dataStates: _productsDataStates, products: _productsDataStates != DataStates.loaded ?[]:_products),
              const SizedBox(height: 30),
              _BuildProductsGrid(title: "Most ordered Products", dataStates: _productsDataStates, products: _productsDataStates != DataStates.loaded ?[]:_products),
            ],
          ),
        ),
      ),
    );
  }
}
class _BuildSlider extends StatelessWidget {
  const _BuildSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        ///Todo change to network image
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(15),
          child: const AppImage(
            height: 300,
            fit: BoxFit.cover,
            image:
            "https://imgix.bustle.com/uploads/image/2020/4/22/7b47eae2-3a26-41c7-9e0c-5141940ea9f4-91593786_547723625865282_5028999264309304315_n.jpg?w=1200&h=630&fit=crop&crop=faces&fm=jpg",
          ),
        ),
        Container(
          height: 170,
          decoration: BoxDecoration(color: const Color(0xFFE9DCD3).withValues(alpha: 0.7)),
          child: Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "50% OFF DISCOUNT \nCUPON CODE : 125865",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const AppImage(image: "offer.svg"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AppImage(image: "offer.svg"),
                    Text(
                      "Hurry up! \nSkin care only !",
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontVariations: <FontVariation>[const FontVariation('wght', 700)],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _BuildProductsGrid extends StatelessWidget {
  const _BuildProductsGrid({required this.title, required this.dataStates, required this.products});

  final String title;

  final DataStates dataStates;
  final List<ProductModel> products;

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
          itemCount: dataStates != DataStates.loaded ? 4 : products.length,
          itemBuilder: (context, index) =>
              dataStates != DataStates.loaded ? const LoadingProductWidget() : AppCard(product: products[index]),
        ),
      ],
    );
  }
}
