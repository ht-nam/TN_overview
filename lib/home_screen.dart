import 'package:flutter/material.dart';
import 'district_overlay.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: InteractiveViewer(
          maxScale: 5,
          minScale: 0.1,
          child: Stack(
            children: [
              Image.asset(
                'assets/map.jpeg',
                width: screenWidth > screenHeight ? screenWidth : null,
                height: screenWidth > screenHeight ? null : screenHeight,
                fit: BoxFit.fill,
              ),
              const DistrictOverlay(),
            ],
          ),
        ),
      ),
    );
  }
}
