import 'package:cosmetics/core/widgets/app_image.dart';
import 'package:cosmetics/core/widgets/my_app_bar.dart';
import 'package:cosmetics/core/widgets/app_button.dart';
import 'package:flutter/material.dart';

import 'home/pages/cart/view.dart';

class CheckOutView extends StatelessWidget {
  const CheckOutView({super.key,  this.cartItems});
  final CartModel? cartItems;


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final color = theme.colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const MyAppBar(haveTitle: true, haveSearchBar: false, title: "Checkout",canPop: true,),
      body: Container(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(color: const Color(0xFFBBD8D9), borderRadius: BorderRadiusGeometry.circular(40)),
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
                  contentPadding: const EdgeInsetsGeometry.symmetric(horizontal: 20),
                  leading: const AppImage(
                    image: "https://www.creativecontrast.com/wp-content/uploads/2017/12/Google-Maps-1.jpg",
                    width: 120,
                    height: 120,
                    fit: BoxFit.fill,
                  ),
                  title: Text("Home", style: Theme.of(context).textTheme.displayMedium),
                  subtitle: Text(
                    "Mansoura, 14 Porsaid St",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 15),
                  ),
                  trailing: Transform.rotate(
                    angle: 270 * 3.14 / 180,
                    child: AppImage(
                      image: "arrow_back.svg",
                      svgColorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
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
                  contentPadding: const EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 5),
                  leading: const AppImage(image: "meza.svg"),
                  title: Text("**** **** **** 0256", style: Theme.of(context).textTheme.displayMedium),
                  trailing: Transform.rotate(
                    angle: 270 * 3.14 / 180,
                    child: AppImage(
                      image: "arrow_back.svg",
                      svgColorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
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
                  trailing: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(color.primary)
                    ),
                    child: Text("Apply",style: textTheme.bodyMedium,),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "—" * 20,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: const TextStyle(letterSpacing: 5.0, color: Color(0xFF434c6d)),
              ),
              const SizedBox(height: 20),
              BuildCheckOut(cartItems: cartItems!,)
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
