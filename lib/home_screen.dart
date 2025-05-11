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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.amber,
                height: 500,
                child: const Center(child: Text("PART 1")),
              ),
              Container(
                color: Colors.red,
                height: 500,
                child: const Center(child: Text("PART 2")),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green.withOpacity(0.4), // Border color
                    width: 2, // Border width
                  ),
                  // borderRadius: BorderRadius.circular(15)
                ),
                // width: screenWidth,
                // height: screenHeight * 0.5,
                width: screenWidth * 0.7,
                height: screenHeight,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final maxWidth = constraints.maxWidth;
                    final maxHeight = constraints.maxHeight;
                    return InteractiveViewer(
                      maxScale: 5,
                      minScale: 0.1,
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/map.jpeg',
                            width: maxWidth > maxHeight ? maxWidth : null,
                            height: maxWidth > maxHeight ? null : maxHeight,
                            fit: BoxFit.fill,
                          ),
                          const DistrictOverlay(),
                        ],
                      ),
                    );
                  }
                ),
              ),
              Container(
                color: Colors.amber,
                height: 500,
                child: const Center(child: Text("PART 4")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
