import 'package:cosmetics/core/widgets/custom_button.dart';
import 'package:cosmetics/views/check_out.dart';
import 'package:cosmetics/views/home/pages/cart/widget/counter.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/app_Image.dart';
import '../../../../core/widgets/app_bar.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const CustomAppBar(
        haveSearchBar: false,
        haveTitle: true,
        haveAction: true,
        title: "My Cart",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///todo show real count of item in cart
              Text(
                "You have 4 products in your cart",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: _cartItems.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final cartItem = _cartItems[index];
                  return Padding(
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
                                    image: cartItem.image,
                                    fit: BoxFit.cover,
                                    width: 120,
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadiusGeometry.circular(
                                      10,
                                    ),
                                  ),
                                  margin: const EdgeInsetsGeometry.all(8),
                                  padding: const EdgeInsetsGeometry.all(3),

                                  ///todo add action of delete item form cart
                                  child: const AppImage(image: "delete.svg"),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cartItem.title,
                                        textAlign: TextAlign.start,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.displayMedium,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        cartItem.description,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontVariations: <FontVariation>[
                                                const FontVariation(
                                                  'wght',
                                                  500,
                                                ),
                                              ],
                                            ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${cartItem.price} EGP",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.displayMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Positioned(
                          bottom: 0,
                          right: 0,
                          child: CounterWidget(),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 50),
              Container(
                padding: const EdgeInsetsGeometry.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                constraints: const BoxConstraints(minWidth: 150, minHeight: 150),
                decoration: BoxDecoration(
                  color: const Color(0xFFBBD8D9),
                  borderRadius: BorderRadiusGeometry.circular(13),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "- REVIEW PAYMENT",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: const Color(0xFF4E5977),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "PAYMENT SUMMARY",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 25,
                        fontVariations: <FontVariation>[
                          const FontVariation('wght', 500),
                        ],
                        color: const Color(0xFF4E5977),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subtotal",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: const Color(0xFF4E5977),
                                fontVariations: <FontVariation>[
                                  const FontVariation('wght', 500),
                                ],
                              ),
                        ),
                        Text(
                          "16.000 EGP",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: const Color(0xFF4E5977),
                                fontVariations: <FontVariation>[
                                  const FontVariation('wght', 600),
                                ],
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
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: const Color(0xFF4E5977),

                                fontVariations: <FontVariation>[
                                  const FontVariation('wght', 500),
                                ],
                              ),
                        ),
                        Text(
                          "TO BE CALCULATED",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: const Color(0xFF4E5977),
                                fontVariations: <FontVariation>[
                                  const FontVariation('wght', 600),
                                ],
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(color: Color(0xFF99CACB)), const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "TOTAL + VAT",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: const Color(0xFF4E5977),

                                fontVariations: <FontVariation>[
                                  const FontVariation('wght', 500),
                                ],
                              ),
                        ),
                        Text(
                          "16.000 EGP",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: const Color(0xFF4E5977),
                                fontVariations: <FontVariation>[
                                  const FontVariation('wght', 600),
                                ],
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    ///todo add nav to check out screen
                    CustomButton(
                      onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckOutView(),)),
                      width: 50,
                      borderRadius: 13,
                      padding: const EdgeInsetsGeometry.symmetric(horizontal: 30),
                      color: const Color(0xFFDA498C),
                      isChildIcon: false,
                      child: Row(
                        children: [
                          const AppImage(image: "order.svg"),
                          Text(
                            "PROCEEED CHECKOUT",
                            style: TextTheme.of(context).bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

final _cartItems = [
  _CartItem(
    image: "https://i.pinimg.com/originals/11/f5/22/11f522c7f8ead5519a4b102723f0a89c.jpg",
    title: "Note Cosmetics",
    description: "Ultra rich mascara for lashes",
    price: 350,
  ),
  _CartItem(
    image: "https://avatars.mds.yandex.net/i?id=e2b53c18ed4ca3f5b84c75ff45a665d658c6c27f-3986150-images-thumbs&n=13",
    title: "ARTDECO",
    description: "Bronzer - 02 ",
    price: 490,
  ),
  _CartItem(
    image: "https://avatars.mds.yandex.net/i?id=dc028fbbe5bf0ac8faa3f09903946f628cee0839-11865037-images-thumbs&n=13",
    title: "Fendi",
    description: "Lipstick - shade 9",
    price: 260,
  ),
  _CartItem(
    image: "https://avatars.mds.yandex.net/i?id=acbcae6e0f0d544566bcc7de26a6ad8f65266309-12619185-images-thumbs&n=13",
    title: "Channel",
    description: "L’eau de perfum N5",
    price: 1500,
  ),
];

class _CartItem {
  final String title, image, description;
  final double price;

  _CartItem({
    required this.title,
    required this.image,
    required this.price,
    required this.description,
  });
}
