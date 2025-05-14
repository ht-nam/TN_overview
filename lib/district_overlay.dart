import 'package:flutter/material.dart';
import 'package:tn/chatbot_popup.dart';

class DistrictOverlay extends StatelessWidget {
  const DistrictOverlay({super.key});

  @override
  Widget build(BuildContext context) {

    return Positioned.fill(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final maxHeight = constraints.maxHeight;
          double baseWidth = 2481;
          double baseHeight = 2363;
          double widthRatio = maxWidth / baseWidth;
          double heightRatio = maxHeight / baseHeight;
          return Stack(
            children: [
              _buildDistrictArea(context, constraints, const Offset(0.095, 0.32), widthRatio, heightRatio, 'Di tích quốc gia đặc biệt ATK Định Hoá'),
              _buildDistrictArea(context, constraints, const Offset(0.135, 0.57 ), widthRatio, heightRatio, 'Suối Kẹm và vùng chè La Bằng'),
              _buildDistrictArea(context, constraints, const Offset(0.315 , 0.38), widthRatio, heightRatio, 'Đền Đuổm'),
              _buildDistrictArea(context, constraints, const Offset(0.317 , 0.585), widthRatio, heightRatio, 'Khu du lịch hồ Núi Cốc'),
              _buildDistrictArea(context, constraints, const Offset(0.357 , 0.7), widthRatio, heightRatio, 'Không gian văn hoá trà, vùng chè Tân Cương'),
              _buildDistrictArea(context, constraints, const Offset(0.425 , 0.585), widthRatio, heightRatio, 'Bảo tàng văn hoá các dân tộc Việt Nam'),
              _buildDistrictArea(context, constraints, const Offset(0.442 , 0.725), widthRatio, heightRatio, 'Khu bảo tồn làng nhà sàn dân tộc sinh thái Thái Hải'),
              _buildDistrictArea(context, constraints, const Offset(0.495 , 0.52), widthRatio, heightRatio, 'Chùa Hang'),
              _buildDistrictArea(context, constraints, const Offset(0.525 , 0.66), widthRatio, heightRatio, 'Di tích lịch sử quốc gia 60 liệt sỹ thanh niên xung phong đại đội 915, đội 91 Bắc Thái'),
              _buildDistrictArea(context, constraints, const Offset(0.53 , 0.79), widthRatio, heightRatio, 'Trung tâm thương mại và du lịch Dũng Tân'),
              _buildDistrictArea(context, constraints, const Offset(0.55 , 0.89), widthRatio, heightRatio, 'Trạm dừng nghỉ Hải Đăng'),
              _buildDistrictArea(context, constraints, const Offset(0.7 , 0.69), widthRatio, heightRatio, 'Đình-đền-chùa Cầu Muối'),
              _buildDistrictArea(context, constraints, const Offset(0.762 , 0.5), widthRatio, heightRatio, 'Di tích quốc gia rừng Khuôn Mánh'),
              _buildDistrictArea(context, constraints, const Offset(0.782 , 0.35), widthRatio, heightRatio, 'Hang Phượng Hoàng, suối Mỏ Gà'),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDistrictArea(BuildContext context, BoxConstraints constraints, Offset position, double withRatio, double heightRatio, String name) {
    double width = 150 * withRatio;
    double height = 150 * heightRatio;
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
