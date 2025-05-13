import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'district_overlay.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _ctrlPressed = false;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final messageController = TextEditingController();

  bool get _isMobile {
    return defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              getFirstArea(),
              Container(
                color: Colors.red,
                height: 500,
                child: const Center(child: Text("PART 2")),
              ),
              getThirdArea(),
              getFourthArea(),
              getFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getFirstArea() {
    return Container(
      height: 900,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/main.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black12, // dark overlay for better text contrast
            BlendMode.darken,
          ),
        ),
      ),
      child: const Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 100.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Thái Nguyên",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  shadows: [
                    Shadow(
                      offset: Offset(0.7, 0.7),
                      blurRadius: 0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Vùng Đất Trà, Văn Hóa và Cơ Hội',
                style: TextStyle(fontSize: 20, height: 2),
              ),
              SizedBox(height: 30),
              Text(
                '''Khám phá đồi chè Tân Cương, Hồ Núi Cốc thơ mộng và di sản cách mạng đặc sắc.
Trung tâm giáo dục, công nghiệp và đầu tư chiến lược phía Bắc.
Hãy đến Thái Nguyên – nơi hội tụ thiên nhiên, con người và tiềm năng phát triển!''',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getThirdArea() {
    return RawKeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKey: (event) {
        if (!_isMobile && event is RawKeyEvent) {
          final ctrl = event.isControlPressed;
          if (ctrl != _ctrlPressed) {
            setState(() {
              _ctrlPressed = ctrl;
            });
          }
        }
      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Bản đồ du lịch Thái Nguyên",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 50),
            LayoutBuilder(
              builder: (context, constraints) {
                return AspectRatio(
                  aspectRatio: 1 / 1, // You can change based on your map aspect
                  child: InteractiveViewer(
                    maxScale: 3,
                    minScale: 1,
                    scaleEnabled: _isMobile || _ctrlPressed,
                    boundaryMargin: const EdgeInsets.all(80),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/map.jpeg',
                            fit: BoxFit.contain, // Keeps image proportions
                          ),
                        ),
                        const DistrictOverlay(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget getFourthArea() {
    return Builder(
      builder: (context) {
        Future<void> sendFeedback() async {
          if (_formKey.currentState!.validate()) {
            final subject = "Đóng góp từ ${nameController.text}";
            final body = messageController.text;
            final email = dotenv.env['RESPONSE_MAIL'] ?? '';

            var url = Uri.https('freeemailapi.vercel.app','/sendEmail/');
            await http.post(
                url,
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode({"toEmail": email, "subject": subject, "body": body}),
            );

            setState(() {
              nameController.text = '';
              messageController.text = '';
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Gửi ý kiến thành công!')),
            );
          }
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          color: Colors.white,
          width: double.infinity,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Material(
                elevation: 0,
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Gửi ý kiến đóng góp',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Tên của bạn',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Vui lòng nhập tên'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: messageController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: 'Ý kiến của bạn',
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Vui lòng nhập nội dung'
                            : null,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: sendFeedback,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.send, color: Colors.white,),
                        label: const Text(
                          'Gửi phản hồi',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getFooter() {
    final phone = dotenv.env['FOOTER_PHONE'] ?? '';
    final mail = dotenv.env['FOOTER_MAIL'] ?? '';
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      color: Colors.grey[200], // Màu nền của footer
      child: Column(
        children: [
          const Text(
            'Liên hệ với chúng tôi',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8, width: double.infinity,),
          Text(
            'Email: $mail',
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 4),
          Text(
            "Số điện thoại: $phone",
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 12),
          // const Text(
          //   '© 2025 Du Lịch Thái Nguyên. All rights reserved.',
          //   style: TextStyle(fontSize: 14, color: Colors.black54),
          // ),
        ],
      ),
    );
  }

}
