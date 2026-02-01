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
    this.errorBuilder,
  });

  final String image;
  final BoxFit? fit;

  final double? height;

  final double? width;
  final ColorFilter? svgColorFilter;
  final ImageErrorWidgetBuilder? errorBuilder;

  Widget showImage(String image) {
    if (image.toLowerCase().startsWith("http") || image.toLowerCase().startsWith("https")) {
      return Image.network(image, fit: fit, height: height, width: width, errorBuilder: errorBuilder);
    } else if (image.toLowerCase().endsWith(".jpg") ||
        image.toLowerCase().endsWith(".jpeg") ||
        image.toLowerCase().endsWith(".png")) {
      return Image.asset("assets/images/$image", fit: fit, height: height, width: width);
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
      return AppImage(
        image: "https://media.istockphoto.com/id/1399588872/vector/corrupted-pixel-file-icon-damage-document-symbol-sign-broken-data-vector.jpg?s=612x612&w=0&k=20&c=ffG6gVLUPfxZkTwjeqdxD67LWd8R1pQTIyIVUi-Igx0=",
        width: 120,
        height: 120,
        errorBuilder: (context, error, stackTrace) => const Text("404"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return showImage(image);
  }
}
