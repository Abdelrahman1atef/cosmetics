import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.image,
    this.fit,
    this.height,
    this.width,
    this.svgColorFilter,
  });

  final String image;
  final BoxFit? fit;

  final double? height;

  final double? width;
  final ColorFilter? svgColorFilter;

  Widget showImage(String image) {
    if (image.toLowerCase().startsWith("http") ||
        image.toLowerCase().startsWith("https")) {
      return Image.network(image, fit: fit, height: height, width: width);
    } else if (image.toLowerCase().endsWith(".jpg") ||
        image.toLowerCase().endsWith(".jpeg") ||
        image.toLowerCase().endsWith(".png")) {
      return Image.asset(
        "assets/images/$image",
        fit: fit,
        height: height,
        width: width,
      );
    } else if (image.toLowerCase().endsWith(".svg")) {
      return SvgPicture.asset(
        "assets/icons/$image",
        fit: fit ?? BoxFit.contain,
        height: height,
        width: width,
        colorFilter: svgColorFilter,
      );
    }
    ///todo handel Lottie file
    // else if (image.contains(".json")) {
    //   return Image.asset(image, fit: fit) ;
    // }
    // else if (image.contains(".gif")) {
    //   return Image.asset(image, fit: fit) ;
    // }
    // else if (image.contains(".webp")) {
    //   return Image.asset(image, fit: fit) ;
    // }
    else {
      return const Placeholder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return showImage(image);
  }
}
