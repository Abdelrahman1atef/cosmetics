import 'package:cosmetics/core/widgets/app_image.dart';
import 'package:cosmetics/core/widgets/my_app_bar.dart';
import 'package:cosmetics/core/widgets/app_button.dart';
import 'package:flutter/material.dart';

class CheckOutView extends StatelessWidget {
  const CheckOutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const MyAppBar(
        haveTitle: true,
        haveSearchBar: false,
        title: "Checkout",
      ),
      body: Container(
        padding: const EdgeInsetsGeometry.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFBBD8D9),
          borderRadius: BorderRadiusGeometry.circular(40),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Delivery to",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: const Color(0xFF4E5977),
                  fontVariations: [const FontVariation('wght', 500)],
                ),
              ),
          
              const SizedBox(height: 20),
              _CustomListTile(
                child: ListTile(
                  contentPadding: const EdgeInsetsGeometry.symmetric(
                    horizontal: 20,
                  ),
                  leading: const AppImage(
                    image:
                        "https://www.creativecontrast.com/wp-content/uploads/2017/12/Google-Maps-1.jpg",
                    width: 120,
                    height: 120,
                    fit: BoxFit.fill,
                  ),
                  title: Text(
                    "Home",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  subtitle: Text(
                    "Mansoura, 14 Porsaid St",
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(fontSize: 15),
                  ),
                  trailing: Transform.rotate(
                    angle: 270 * 3.14 / 180,
                    child: AppImage(
                      image: "arrow_back.svg",
                      svgColorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Payment Method",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: const Color(0xFF4E5977),
                  fontVariations: [const FontVariation('wght', 500)],
                ),
              ),
              const SizedBox(height: 20),
              _CustomListTile(
                child: ListTile(
                  contentPadding: const EdgeInsetsGeometry.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  leading: const AppImage(image: "meza.svg"),
                  title: Text(
                    "**** **** **** 0256",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  trailing: Transform.rotate(
                    angle: 270 * 3.14 / 180,
                    child: AppImage(
                      image: "arrow_back.svg",
                      svgColorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _CustomListTile(
                child: ListTile(
                  contentPadding: const EdgeInsetsGeometry.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  leading: const AppImage(image: "voucher.svg", width: 30),
                  title: Text(
                    "Add vaucher",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  trailing: AppButton(
                    width: 20,
                    borderRadius: 100,
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 30,vertical: 10),
                    onPressed: () {},
                    text: "Apply",
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "—" * 20,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: const TextStyle(
                  letterSpacing: 5.0,
                  color: Color(0xFF434c6d),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "- REVIEW PAYMENT",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: const Color(0xFF4E5977)),
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
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF4E5977),
                      fontVariations: <FontVariation>[
                        const FontVariation('wght', 500),
                      ],
                    ),
                  ),
                  Text(
                    "16.000 EGP",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF4E5977),
          
                      fontVariations: <FontVariation>[
                        const FontVariation('wght', 500),
                      ],
                    ),
                  ),
                  Text(
                    "TO BE CALCULATED",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF4E5977),
          
                      fontVariations: <FontVariation>[
                        const FontVariation('wght', 500),
                      ],
                    ),
                  ),
                  Text(
                    "16.000 EGP",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
              Padding(
                padding: const EdgeInsetsGeometry.symmetric(horizontal: 50),
                child: AppButton(
                  onPressed: () {},
                  width: 50,
                  borderRadius: 50,
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 30,vertical: 30),
                  color: Theme.of(context).primaryColor,
                  isChildIcon: false,
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppImage(image: "order.svg"),
                      Text(
                        "ORDER",
                        style: TextTheme.of(context).bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF73B9BB), width: 2),
          borderRadius: BorderRadiusGeometry.circular(30),
        ),
        child: child,
      ),
    );
  }
}
