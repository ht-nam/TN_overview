import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tn/chatbot_popup.dart';

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
              _buildDistrictArea(context, constraints, const Offset(0.095, 0.3), widthRatio, heightRatio, 'Di tích quốc gia đặc biệt ATK Định Hoá'),
              _buildDistrictArea(context, constraints, const Offset(0.135, 0.57 ), widthRatio, heightRatio, 'Suối Kẹm và vùng chè La Bằng'),
              _buildDistrictArea(context, constraints, const Offset(0.315 , 0.37), widthRatio, heightRatio, 'Đền Đuổm'),
              _buildDistrictArea(context, constraints, const Offset(0.317 , 0.585), widthRatio, heightRatio, 'Khu du lịch hồ Núi Cốc'),
              _buildDistrictArea(context, constraints, const Offset(0.357 , 0.7), widthRatio, heightRatio, 'Không gian văn hoá trà, vùng chè Tân Cương'),
              _buildDistrictArea(context, constraints, const Offset(0.425 , 0.585), widthRatio, heightRatio, 'Bảo tàng văn hoá các dân tộc Việt Nam'),
              _buildDistrictArea(context, constraints, const Offset(0.442 , 0.725), widthRatio, heightRatio, 'Khu bảo tồn làng nhà sàn dân tộc sinh thái Thái Hải'),
              _buildDistrictArea(context, constraints, const Offset(0.495 , 0.52), widthRatio, heightRatio, 'Chùa Hang'),
              _buildDistrictArea(context, constraints, const Offset(0.525 , 0.66), widthRatio, heightRatio, 'Di tích lịch sử quốc gia 60 liệt sỹ thanh niên xung phong đại đội 915, đội 91 Bắc Thái'),
              _buildDistrictArea(context, constraints, const Offset(0.53 , 0.79), widthRatio, heightRatio, 'Trung tâm thương mại và du lịch Dũng Tân'),
              _buildDistrictArea(context, constraints, const Offset(0.55 , 0.9), widthRatio, heightRatio, 'Trạm dừng nghỉ Hải Đăng'),
              _buildDistrictArea(context, constraints, const Offset(0.7 , 0.69), widthRatio, heightRatio, 'Đình-đền-chùa Cầu Muối'),
              _buildDistrictArea(context, constraints, const Offset(0.762 , 0.5), widthRatio, heightRatio, 'Di tích quốc gia rừng Khuôn Mánh'),
              _buildDistrictArea(context, constraints, const Offset(0.782 , 0.34), widthRatio, heightRatio, 'Hang Phượng Hoàng, suối Mỏ Gà'),
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
              builder: (_) => ChatbotPopup(title: name),
            );
          },
          child: Container(
            width: width,
            height: height,
            color: Colors.transparent,
            child: const Center(child: Icon(Icons.location_on, color: Colors.transparent)),
          ),
        ),
      ),
    );
  }
}
