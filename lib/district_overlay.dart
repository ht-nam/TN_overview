import 'dart:math';

import 'package:flutter/material.dart';
import 'district_detail_popup.dart';

class DistrictOverlay extends StatelessWidget {
  const DistrictOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double minBase = min(screenHeight, screenWidth);
    double baseWidth = minBase == screenWidth ? minBase : (minBase / 1430  * 1494);
    double baseHeight = minBase == screenHeight ? minBase : (minBase / 1494 * 1430);

    double widthRatio = screenWidth / baseWidth;
    double heightRatio = screenHeight / baseHeight;

    return Positioned.fill(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              _buildDistrictArea(context, constraints, const Offset(0.095, 0.3), widthRatio, heightRatio, '1'),
              _buildDistrictArea(context, constraints, const Offset(0.135, 0.57 ), widthRatio, heightRatio, '2'),
              _buildDistrictArea(context, constraints, const Offset(0.315 , 0.37), widthRatio, heightRatio, '3'),
              _buildDistrictArea(context, constraints, const Offset(0.317 , 0.585), widthRatio, heightRatio, '4'),
              _buildDistrictArea(context, constraints, const Offset(0.357 , 0.7), widthRatio, heightRatio, '5'),
              _buildDistrictArea(context, constraints, const Offset(0.425 , 0.585), widthRatio, heightRatio, '6'),
              _buildDistrictArea(context, constraints, const Offset(0.442 , 0.725), widthRatio, heightRatio, '7'),
              _buildDistrictArea(context, constraints, const Offset(0.495 , 0.52), widthRatio, heightRatio, '8'),
              _buildDistrictArea(context, constraints, const Offset(0.525 , 0.66), widthRatio, heightRatio, '9'),
              _buildDistrictArea(context, constraints, const Offset(0.53 , 0.79), widthRatio, heightRatio, '10'),
              _buildDistrictArea(context, constraints, const Offset(0.55 , 0.9), widthRatio, heightRatio, '11'),
              _buildDistrictArea(context, constraints, const Offset(0.7 , 0.69), widthRatio, heightRatio, '12'),
              _buildDistrictArea(context, constraints, const Offset(0.762 , 0.5), widthRatio, heightRatio, '13'),
              _buildDistrictArea(context, constraints, const Offset(0.782 , 0.34), widthRatio, heightRatio, '14'),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDistrictArea(BuildContext context, BoxConstraints constraints, Offset position, double withRatio, double heightRatio, String name) {
    double width = 50 * withRatio;
    double height = 50 * heightRatio;
    return Positioned(
      left: position.dx * constraints.maxWidth,
      top: position.dy * constraints.maxHeight,
      child: Transform.translate(
        offset: Offset(0 - width / 2, 0 - height / 2),
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => DistrictDetailPopup(districtName: name),
            );
          },
          child: Container(
            width: width,
            height: height,
            color: Colors.transparent,
            child: const Center(child: Icon(Icons.location_on, color: Colors.red)),
          ),
        ),
      ),
    );
  }
}
