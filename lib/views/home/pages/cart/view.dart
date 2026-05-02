import 'dart:math';

import 'package:cosmetics/core/widgets/app_button.dart';
import 'package:cosmetics/views/check_out.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/logic/helper_method.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/my_app_bar.dart';
import '../../view.dart';

part 'widgets/counter.dart';

class CartModel {
  late final List<Items> items;
  late final int totalCents;

  CartModel({required this.items, required this.totalCents});

  CartModel.fromJson(Map<String, dynamic> json) {
    items = List<Map<String, dynamic>>.from(json['items'] ?? []).map((e) => Items.fromJson(e)).toList();
    totalCents = ((json['total'] ?? 0) * 100).round();
  }
  double get total => totalCents / 100;
  CartModel copyWith({
    List<Items>? items,
    int ? totalCents,
  }) {
    return CartModel(
      items: items ?? this.items,
      totalCents: totalCents ?? this.totalCents,
    );
  }
}

class Items {
  late final int productId;
  late final String productName;
  late final int quantity;
  late final int priceCents ;
  late final String imageUrl;
  double get price => priceCents / 100;
  Items.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'] ?? json['productId'] ?? 0;
    productName = json['product_name_en'] ?? json['product_name_ar'] ?? json['productName'] ?? "";
    quantity = json['quantity'] ?? 0;
    priceCents  = ((json['price'] ?? 0) * 100).round();
    imageUrl = json['image_url'] ?? json['imageUrl'] ?? "";
  }
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const MyAppBar(haveSearchBar: false, haveTitle: true, haveAction: true, title: "My Cart"),
      body: ValueListenableBuilder<DataStates>(
        valueListenable: cartItemsStates,
        builder: (context, cartItemsStates, child) => cartItemsStates == DataStates.loading
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Column(
                  children: [
                    ...List.generate(
                      2,
                      (index) => Container(
                        height: 110,
                        margin: const EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadiusGeometry.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      height: 400,
                      margin: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 30),
                      decoration: BoxDecoration(
                        color: const Color(0xFFBBD8D9),
                        borderRadius: BorderRadiusGeometry.circular(13),
                      ),
                    ),
                  ],
                ),
              )
            : cartItemsStates == DataStates.error
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppImage(image: "https://cdn-icons-png.flaticon.com/512/4033/4033861.png"),
                      const SizedBox(height: 20),
                      Text("Something went wrong", style: textTheme.titleLarge, textAlign: TextAlign.center),
                      const SizedBox(height: 20),
                      AppButton(onPressed: () => getCartReq(), text: "Try again"),
                    ],
                  ),
                ),
              )
            : cartItemsStates == DataStates.loaded
            ? ValueListenableBuilder<CartModel>(
                valueListenable: cartNotifier,
                builder: (context, cartItems, child) => Padding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 20).copyWith(bottom: kBottomNavigationBarHeight*2),
                  child: cartItems.items.isEmpty
                      ? const Center(child: AppImage(image: "empty_cart.svg", height: 200))
                      : CustomScrollView(
                          slivers: [
                            if (cartItems.items.isNotEmpty) ...[
                              SliverToBoxAdapter(
                                child: Text(
                                  "You have ${cartItems.items.length} products in your cart",
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              _BuildProductList(cartItems: cartItems),
                              SliverToBoxAdapter(child: BuildCheckOut(cartItems: cartItems)),
                            ],
                          ],
                        ),
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}

class _BuildProductList extends StatefulWidget {
  const _BuildProductList({required this.cartItems});
  final CartModel cartItems;

  @override
  State<_BuildProductList> createState() => _BuildProductListState();
}

class _BuildProductListState extends State<_BuildProductList> {
  int? _deletingProductId;
  Future<void> _deleteCartItem({required int productId}) async {
    setState(() {
      _deletingProductId = productId;
    });
    final response = await DioHelper.deleteData(
      endpoint: "api/Cart/remove/$productId",
    );
    if (response.isSuccess) {
      final oldCart = cartNotifier.value;

      final deletedItem =
      oldCart.items.firstWhere((e) => e.productId == productId);

      final updatedItems = oldCart.items
          .where((e) => e.productId != productId)
          .toList();

      final updatedTotal =
          oldCart.totalCents - (deletedItem.priceCents * deletedItem.quantity);

      cartNotifier.value = oldCart.copyWith(
        items: updatedItems,
        totalCents: updatedTotal,
      );
      showMsg(response.msg);
    } else {
      showMsg(response.msg);
    }
    setState(() {
      _deletingProductId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        if (index.isOdd) return const Divider();
        final cartItem = widget.cartItems.items[index ~/ 2];
        return Padding(
          padding: const EdgeInsetsGeometry.symmetric(vertical: 40),
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
                          image: imageList[Random().nextInt(imageList.length)],
                          // image: cartItem.imageUrl,
                          fit: BoxFit.cover,
                          width: 120,
                          height: 120,
                          errorBuilder: (context, error, stackTrace) =>  AppImage(
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            image:
                            imageList[Random().nextInt(imageList.length)],
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadiusGeometry.circular(10)),
                        margin: const EdgeInsetsGeometry.all(8),
                        padding: const EdgeInsetsGeometry.all(3),
                        child: InkWell(
                          onTap:() =>  _deleteCartItem(productId: cartItem.productId),
                          child: Builder(
                            builder: (context) {
                              final isDeleting = _deletingProductId == cartItem.productId;

                              if (isDeleting) {
                                return const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                );
                              }

                              return const AppImage(
                                image: "delete.svg",
                                width: 24,
                                height: 24,
                              );
                            }
                          ),
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
              Positioned(bottom: 0, right: 0, child: _CounterWidget(cartItem:cartItem)),
            ],
          ),
        );
      },childCount: widget.cartItems.items.length* 2 - 1),
    );
  }
}

class BuildCheckOut extends StatelessWidget {
  const BuildCheckOut({super.key, required this.cartItems});

  final CartModel cartItems;

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
                "${cartItems.total} EGP",
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
                "${cartItems.total} EGP",
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
                goto( CheckOutView(cartItems:cartItems)),
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
final imageList = [
  "https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?q=80&w=1000&auto=format&fit=crop",
  "https://images.unsplash.com/photo-1512496015851-a90fb38ba796?q=80&w=1000&auto=format&fit=crop",
  "https://images.unsplash.com/photo-1571781926291-c477ebfd024b?q=80&w=1000&auto=format&fit=crop",
  "https://images.unsplash.com/photo-1556229010-6c3f2c9ca5f8?q=80&w=1000&auto=format&fit=crop",
  "https://images.unsplash.com/photo-1612817288484-6f916006741a?q=80&w=1000&auto=format&fit=crop",
  "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?q=80&w=1000&auto=format&fit=crop",
];