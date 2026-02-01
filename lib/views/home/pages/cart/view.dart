import 'package:cosmetics/core/widgets/app_button.dart';
import 'package:cosmetics/views/check_out.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/logic/helper_method.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/my_app_bar.dart';

part 'widgets/counter.dart';

class CartModel {
  late final List<Items> items;
  late final num total;

  CartModel({required this.items, required this.total});

  CartModel.fromJson(Map<String, dynamic> json) {
    items = List<Map<String, dynamic>>.from(json['items']).map((e) => Items.fromJson(e)).toList();
    total = json['total'];
  }
}

class Items {
  late final int productId;
  late final String productName;
  late final int quantity;
  late final double price;

  Items.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    quantity = json['quantity'];
    price = json['price'];
  }
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartModel _cartItems;
  DataStates _cartItemsStates = DataStates.uninitialized;

  Future<void> _productsReq() async {
    _cartItemsStates = DataStates.loading;
    setState(() {});
    final response = await DioHelper.getData("api/Cart");
    if (response.isSuccess) {
      _cartItemsStates = DataStates.loaded;
      _cartItems = CartModel.fromJson(response.data);
      // _cartItemsStates = DataStates.error;
    } else {
      _cartItemsStates = DataStates.error;
      showMsg(response.msg);
      _cartItems = CartModel(items: [], total: 0);
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
      appBar: const MyAppBar(haveSearchBar: false, haveTitle: true, haveAction: true, title: "My Cart"),
      body: _cartItemsStates != DataStates.loaded
          ? Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(height: 110, color: Colors.grey.shade300),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsetsGeometry.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_cartItems.items.isEmpty) ...[const Center(child: AppImage(image: "empty_cart.svg",height: 200,))],

                    if (_cartItems.items.isNotEmpty) ...[
                      Text(
                        "You have ${_cartItems.items.length} products in your cart",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],

                    // const SizedBox(height: 20),
                    // _BuildProductList(cartItems: _cartItems, cartItemsStates: _cartItemsStates),
                    // const SizedBox(height: 50),
                    // _BuildCheckOut(),
                    // const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
    );
  }
}

class _BuildProductList extends StatelessWidget {
  const _BuildProductList({required this.cartItems, required this.cartItemsStates});

  final CartModel cartItems;
  final DataStates cartItemsStates;

  GestureTapCallback? _deleteCartItem({required int productId}) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      itemCount: cartItemsStates != DataStates.loaded ? 3 : cartItems.items.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final cartItem = cartItems.items[index];
        return cartItemsStates != DataStates.loaded
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(height: 80),
              )
            : Padding(
                padding: const EdgeInsetsGeometry.symmetric(vertical: 20),
                child: Stack(
                  children: [
                    Row(
                      spacing: 10,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: AppImage(
                                image: "cartItems.image",
                                fit: BoxFit.cover,
                                width: 120,
                                errorBuilder: (context, error, stackTrace) => const AppImage(
                                  image:
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTwq662al2lIlBPF1hUNkJxD3U0_f9r09CmA&s",
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadiusGeometry.circular(10),
                              ),
                              margin: const EdgeInsetsGeometry.all(8),
                              padding: const EdgeInsetsGeometry.all(3),

                              ///todo add action of delete item form cart
                              child: GestureDetector(
                                onTap: _deleteCartItem(productId: cartItem.productId),
                                child: const AppImage(image: "delete.svg"),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartItem.productName,
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context).textTheme.displayMedium,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    // cartItem.description,
                                    "Ultra rich mascara for lashes",
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontVariations: <FontVariation>[const FontVariation('wght', 500)],
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Text("${cartItem.price} EGP", style: Theme.of(context).textTheme.displayMedium),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Positioned(bottom: 0, right: 0, child: _CounterWidget()),
                  ],
                ),
              );
      },
    );
  }
}

class _BuildCheckOut extends StatelessWidget {
  const _BuildCheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(color: const Color(0xFFBBD8D9), borderRadius: BorderRadiusGeometry.circular(13)),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "- REVIEW PAYMENT",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: const Color(0xFF4E5977)),
          ),
          const SizedBox(height: 20),
          Text(
            "PAYMENT SUMMARY",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 25,
              fontVariations: <FontVariation>[const FontVariation('wght', 500)],
              color: const Color(0xFF4E5977),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF4E5977),
                  fontVariations: <FontVariation>[const FontVariation('wght', 500)],
                ),
              ),
              Text(
                "16.000 EGP",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF4E5977),
                  fontVariations: <FontVariation>[const FontVariation('wght', 600)],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "SHIPPING FEES",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF4E5977),

                  fontVariations: <FontVariation>[const FontVariation('wght', 500)],
                ),
              ),
              Text(
                "TO BE CALCULATED",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF4E5977),
                  fontVariations: <FontVariation>[const FontVariation('wght', 600)],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: Color(0xFF99CACB)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "TOTAL + VAT",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF4E5977),

                  fontVariations: <FontVariation>[const FontVariation('wght', 500)],
                ),
              ),
              Text(
                "16.000 EGP",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF4E5977),
                  fontVariations: <FontVariation>[const FontVariation('wght', 600)],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          AppButton(
            onPressed: () =>
                Navigator.push(context, MaterialPageRoute<void>(builder: (context) => const CheckOutView())),
            borderRadius: 13,
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 0),
            color: const Color(0xFFDA498C),
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppImage(image: "order.svg"),
                Text("PROCEEED CHECKOUT", style: TextTheme.of(context).bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
