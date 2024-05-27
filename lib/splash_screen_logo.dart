import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreenLogo extends StatelessWidget {
  final double width;
  final double height;

  const SplashScreenLogo({super.key, this.width = 200, this.height = 200});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: SvgPicture.asset(
          'assets/logo/logo.svg', // Replace with the path to your SVG logo
          width: width,
          height: height,
        ),
      ),
    );
  }
}
