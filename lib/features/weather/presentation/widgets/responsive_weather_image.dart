import 'package:flutter/material.dart';

class ResponsiveWeatherImage extends StatelessWidget {
  const ResponsiveWeatherImage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double containerWidth = constraints.maxWidth;
        final bool isWide = containerWidth > 300;
        final double aspectRatio = isWide ? (16 / 9) : (4 / 3);

        return Center(
          child: Container(
            width: containerWidth,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 56),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: AspectRatio(
              aspectRatio: aspectRatio,
              child: Center(
                child: Image.asset(
                  'assets/images/sunny_image.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
