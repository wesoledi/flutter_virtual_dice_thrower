import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FrostedGlassBox extends StatelessWidget {
  final double width, height;
  final Widget child;

  const FrostedGlassBox({
    @required this.width,
    @required this.height,
    @required this.child
    }) : super();

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(20.0);
    double blurSigma = 8.0;

    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        width: width,
        height: height,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: blurSigma,
                sigmaY: blurSigma,
              ),
              child: Container(
                width: width,
                height: height,
              ),
            ),
            Opacity(
              opacity: 0.15,
              child: Image.asset(
                "assets/images/frozen1.png",
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: Border.all(color: Colors.white.withOpacity(0.35)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.75),
                    Colors.white.withOpacity(0.35),
                  ],
                  stops: [0.0, 1.0]
                ),
              ),
              child: child,
            ),
          ],
        ),
      )
    );
  }
}