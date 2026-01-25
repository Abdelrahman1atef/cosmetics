import 'package:flutter/material.dart';

import '../../../core/widgets/app_image.dart';
import '../../../core/widgets/my_app_bar.dart';
import '../../../core/widgets/app_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              const SizedBox(height:20),
              Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  ///Todo change to network image
                  ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(15),
                      child: const AppImage(height: 300,fit: BoxFit.cover,image:"https://imgix.bustle.com/uploads/image/2020/4/22/7b47eae2-3a26-41c7-9e0c-5141940ea9f4-91593786_547723625865282_5028999264309304315_n.jpg?w=1200&h=630&fit=crop&crop=faces&fm=jpg")),
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
                              const AppImage(image: "offer.svg"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AppImage(image:"offer.svg"),
                              Text(
                                "Hurry up! \nSkin care only !",
                                style: Theme.of(context).textTheme.displayMedium
                                    ?.copyWith(
                                      fontVariations: <FontVariation>[
                                        const FontVariation('wght', 700),
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
              const SizedBox(height:30),
              Text(
                "Top rated products",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height:30),
              ///todo handel data that come from api
              GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio:  176/237
                ),
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: const [
                  AppCard(image: "https://i.pinimg.com/originals/11/f5/22/11f522c7f8ead5519a4b102723f0a89c.jpg"),
                  AppCard(image: "https://avatars.mds.yandex.net/i?id=e2b53c18ed4ca3f5b84c75ff45a665d658c6c27f-3986150-images-thumbs&n=13"),
                  AppCard(image: "https://avatars.mds.yandex.net/i?id=dc028fbbe5bf0ac8faa3f09903946f628cee0839-11865037-images-thumbs&n=13"),
                  AppCard(image: "https://avatars.mds.yandex.net/i?id=acbcae6e0f0d544566bcc7de26a6ad8f65266309-12619185-images-thumbs&n=13"),
                ],
              ),
              const SizedBox(height:30),
              Text(
                "Most ordered Products",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height:30),
              ///todo handel data that come from api
              GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 176/237
                ),
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: const [
                  AppCard(image: "https://i.pinimg.com/originals/ef/c1/c8/efc1c8ccfd1960487a687a0b67957220.jpg"),
                  AppCard(image: "https://yandex-images.clstorage.net/GNl56L086/970bb7Nf/EB3sjFU1OMrQlZX-SFjeU7xNyO1AbP-PFHTuS7xsb7B0_zxWQ-vcEpF7yxSYC88scx_XNkiTWvORCGZvxJmX_mA56f1x8ZzrpQDhn_0YXmPsbB05cX06L1GlSm6MmSrWgi1rJCBJaiWDTGz1bUsa-VK7UkatRTySpvqTrdOK1cqwjn5sJQZ4nsCXJ2o7iv5BPX8ubDFsqm3Cpx5-WNweR7GuS3YyiplkQ7-cNCwo6lnB32ImLISsVweaoz8TG_YpkCxuvkdGOL4i91Zb2WmdkHwOjz-wTShtwsQMzgvdTbdQ3wsngCi7dkAev5RdKHvKED9SFJwF7yenuyHNsciU23MO_M9FFNleULS1ifr4_pKerW2vQu8Z_PFnDI4b71324xxLpQOoCGdTntxHfcrYa3OvE-X918wlBojwf7Kpl5rxjq38FlTIXSN3hHs6unyhP398TWIu2w9y5w1ve_28tEH9KmYhKRiEUk99NO5JKjoBHhP3PAfeJBc4c78i-SbKor48vBcEi0xTF5a7KooNo57fLk0zDrkd41aMPchtrmVhr_v0sVqYV-FP_XbuSHuZQQ6i193m7-QXWCH_4XhXOHId7u9WZipsEqUki-i4jBCeXX9c4O6K7wNXXa873Hy2MY8aJuEJK5RTHZzUPTmYC2GtwWU_dt5W1ish_TBahOqAPZ8_tbU7PQPUl6nJCB4T71y-j3M_2A8gp3-cuiz_BtFeC0eDe9mXYg4PF-8Z28gTrXN0bMSdR-e4I5-xura5Q358X_RlSF2zFsSrOTu-E48-vTwiTOhP0IUu_3osXbUCjenUcLkLdzOfjtfMCJpJ0S9xZLz2jMXHuxIf4ap1CXGMfo92JTqtoVVVugqLXgGe3B0P4k_IfqNkzr_47E11UfxrhFAouiRgbG7mjbrayJAtkfSf9_7EBpoD7iFZt2lS_Q2sF5ZZDVDV9NopuI6gf20djVL_Kc0xpjyu-T2fM"),
                  AppCard(image: "https://avatars.mds.yandex.net/i?id=3a37baaa2bb742cce7e3393947bfbf63aec27dc729a2047d-12928152-images-thumbs&n=13"),
                  AppCard(image: "https://avatars.mds.yandex.net/i?id=48c25027624b05d6e1f6b99ae88e8641c944f6b8-4904264-images-thumbs&n=13"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
