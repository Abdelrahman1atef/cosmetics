import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const CustomAppBar(haveSearchBar: true, haveTitle: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  ///Todo change to network image
                  Image.asset("assets/images/temp_home_image_ad.png"),
                  Container(
                    height: 170,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9DCD3).withValues(alpha: 0.7),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsGeometry.symmetric(
                        horizontal: 25,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "50% OFF DISCOUNT \nCUPON CODE : 125865",
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineMedium,
                              ),
                              SvgPicture.asset("assets/svgs/offer.svg"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset("assets/svgs/offer.svg"),
                              Text(
                                "Hurry up! \nSkin care only !",
                                style: Theme.of(context).textTheme.displayMedium
                                    ?.copyWith(
                                      fontVariations: <FontVariation>[
                                        FontVariation('wght', 700),
                                      ],
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(30),
              Text(
                "Top rated products",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const Gap(30),
              ///todo handel data that come from api
              GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7
                ),
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: const [
                  CustomCard(image: "assets/images/image1.jpg"),
                  CustomCard(image: "assets/images/image2.jpg"),
                  CustomCard(image: "assets/images/image3.jpg"),
                  CustomCard(image: "assets/images/image4.jpg"),
                ],
              ),
              const Gap(30),
              Text(
                "Most ordered Products",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              ///todo handel data that come from api
              GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7
                ),
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: const [
                  CustomCard(image: "assets/images/image1.jpg"),
                  CustomCard(image: "assets/images/image2.jpg"),
                  CustomCard(image: "assets/images/image3.jpg"),
                  CustomCard(image: "assets/images/image4.jpg"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
