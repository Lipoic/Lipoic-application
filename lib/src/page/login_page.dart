import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lipoic/src/lipoic_app.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: Container(color: Theme.of(context).backgroundColor),
      ),
      body: Container(
          constraints: const BoxConstraints.expand(),
          color: AppTheme.color.cyanBackground,
          child: const CustomPaint(
              painter: _BackgroundPainter(), child: _LoginWidget())),
    );
  }
}

class _LoginWidget extends StatefulWidget {
  const _LoginWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<_LoginWidget> {
  bool keepLogin = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: kSplitHight),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: kSplitWidth),
            Transform.scale(
                scale: 2, child: const BackButton(color: Color(0XFF457676)))
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Container(
            color: AppTheme.color.cyanBackground,
            child: Column(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 57,
                    child: TextField(
                      style: const TextStyle(color: Color(0xFFABABAB)),
                      decoration: InputDecoration(
                          hintText: "使用者名稱或電子郵件",
                          hintStyle: AppTheme.text.fieldHint,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          fillColor: const Color(0x557C7B7B),
                          filled: true),
                    )),
                SizedBox(height: MediaQuery.of(context).size.width * 0.08),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 57,
                    child: TextField(
                      style: const TextStyle(color: Color(0xFFABABAB)),
                      decoration: InputDecoration(
                          hintText: "密碼",
                          hintStyle: AppTheme.text.fieldHint,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          fillColor: const Color(0x557C7B7B),
                          filled: true),
                    )),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                            value: keepLogin,
                            onChanged: (value) {
                              keepLogin = value!;
                              setState(() {});
                            }),
                        const Text("保持登入",
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                      ],
                    ),
                    const Text(
                      "忘記密碼 ?",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )
                  ],
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: 282,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("登入", style: AppTheme.text.mediumTitle),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  const _BackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    drawRect(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void drawRect(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;

    final paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = const Color(0xFFA4DFDA);

    final paint3 = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = const Color(0xFF819FA4);

    final double sideLength =
        width / 2 * sqrt(2) * max(0.8, 1.1 - width / height);
    canvas.save();
    Path path = Path()
      ..moveTo(-10, -10)
      ..lineTo(sideLength * sqrt(2) / 2 + 15, -10)
      ..lineTo(-10, sideLength * sqrt(2) / 2 + 15);

    canvas.drawShadow(path, const Color(0xFF000000), 10, false);
    canvas.restore();

    canvas.save();
    Rect rect = Offset.zero & Size(sideLength, sideLength);
    canvas.translate(-sideLength / 2, -sideLength / 2);
    rotate(canvas, rect.width, rect.height, 45 * 3.14 / 180);
    canvas.drawRect(rect, paint);

    canvas.restore();

    canvas.save();
    Path path2 = Path()
      ..moveTo(width + 10, height + 10)
      ..lineTo(width - 100, height + 10)
      ..lineTo(width + 10, height - 80);

    canvas.drawShadow(path2, const Color(0xFF000000), 10, false);
    canvas.restore();

    canvas.save();
    var rect3 = Offset.zero & const Size(100, 100);
    canvas.translate(width - 52, height - 40);
    rotate(canvas, rect3.width, rect3.height, 50 * 3.14 / 180);
    canvas.drawRect(rect3, paint3);

    canvas.restore();
  }

  void rotate(Canvas canvas, double dx, double dy, double angle) {
    final r = sqrt(dx * dx + dy * dy) / 2;
    final alpha = atan(dx / dy);
    final beta = alpha + angle;
    final shiftY = r * sin(beta);
    final shiftX = r * cos(beta);
    final translateX = dx / 2 - shiftX;
    final translateY = dy / 2 - shiftY;
    canvas.translate(translateX, translateY);
    canvas.rotate(angle);
  }
}
