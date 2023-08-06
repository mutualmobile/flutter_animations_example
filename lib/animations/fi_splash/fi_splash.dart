import 'dart:math';

import 'package:flutter/material.dart';

import '../../contributors_card.dart';

class FiSplashScreen extends StatefulWidget {
  const FiSplashScreen({super.key});

  @override
  State<FiSplashScreen> createState() => _FiSplashScreenState();
}

class _FiSplashScreenState extends State<FiSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _circleAlpha;
  late Animation<double> _circleAlphaValue;

  late AnimationController _squareAlpha;
  late Animation<double> _squareAlphaValue;

  late AnimationController _heightFactor;
  late Animation<double> _heightFactorValue;

  late AnimationController _squareRotation;
  late Animation<double> _squareRotationValue;

  @override
  void initState() {
    super.initState();
    _circleAlpha = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1300));

    _circleAlphaValue = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: ConstantTween<double>(1.0), weight: 65),
      TweenSequenceItem(tween: ConstantTween<double>(0.0), weight: 65),
    ]).animate(CurvedAnimation(
      parent: _circleAlpha,
      curve: Curves.linear,
    ));

    _squareAlpha = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1300));

    _squareAlphaValue = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: ConstantTween<double>(0.0), weight: 65),
      TweenSequenceItem(tween: ConstantTween<double>(1.0), weight: 65),
    ]).animate(CurvedAnimation(
      parent: _squareAlpha,
      curve: Curves.linear,
    ));

    _squareRotation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1300));

    _squareRotationValue = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: ConstantTween<double>(45), weight: 65),
      TweenSequenceItem(
        tween: Tween<double>(begin: 45, end: 135)
            .chain(CurveTween(curve: Curves.fastOutSlowIn)),
        weight: 30,
      ),
      TweenSequenceItem(tween: ConstantTween<double>(135), weight: 5),
      TweenSequenceItem(
        tween: Tween<double>(begin: 135, end: 225)
            .chain(CurveTween(curve: Curves.fastOutSlowIn)),
        weight: 30,
      ),
    ]).animate(CurvedAnimation(
      parent: _squareRotation,
      curve: Curves.linear,
    ));

    _heightFactor = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1300));

    _heightFactorValue = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.27, end: 0.0)
            .chain(CurveTween(curve: Curves.fastOutSlowIn)),
        weight: 30,
      ),
      TweenSequenceItem(tween: ConstantTween<double>(0.0), weight: 5),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 0.27)
            .chain(CurveTween(curve: Curves.fastOutSlowIn)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.27, end: 0.0)
            .chain(CurveTween(curve: Curves.fastOutSlowIn)),
        weight: 30,
      ),
      TweenSequenceItem(tween: ConstantTween<double>(0.0), weight: 5),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: 0.27)
            .chain(CurveTween(curve: Curves.fastOutSlowIn)),
        weight: 30,
      ),
    ]).animate(CurvedAnimation(
      parent: _heightFactor,
      curve: Curves.linear,
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _squareAlpha.repeat();
    _circleAlpha.repeat();
    _squareRotation.repeat();
    _heightFactor.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _squareAlpha.dispose();
    _squareRotation.dispose();
    _circleAlpha.dispose();
    _heightFactor.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: const Color(0xff00b495),
          child: Center(
            child: AnimatedBuilder(
              animation: Listenable.merge(
                [_circleAlpha, _squareRotation, _heightFactor, _squareAlpha],
              ),
              builder: (_, __) {
                return CustomPaint(
                  size: const Size(100, 100),
                  painter: FiIconPainter(
                    _circleAlphaValue.value,
                    _squareAlphaValue.value,
                    _squareRotationValue.value,
                    _heightFactorValue.value,
                  ),
                );
              },
            ),
          ),
        ),
        const Positioned(
          left: 0,
          right: 0,
          bottom: 32,
          height: 100,
          child: ContributorsCard(
            imageUrl:
                "https://ca.slack-edge.com/T02TLUWLZ-U02CDNRLMSA-4aa8ad906c93-72",
            name: "Aditya Bhawsar",
            email: "aditya.bhawsar@mutualmobile.com",
          ),
        ),
      ],
    );
  }
}

class FiIconPainter extends CustomPainter {
  final double circleAlpha;
  final double squareAlpha;
  final double squareRotation;
  final double heightRatio;

  FiIconPainter(
    this.circleAlpha,
    this.squareAlpha,
    this.squareRotation,
    this.heightRatio,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paintWord = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final fPath = Path();
    fPath.moveTo(size.width * 0.5, size.height * 0.25);
    fPath.lineTo(size.width * 0.3, size.height * 0.25);
    fPath.quadraticBezierTo(
      size.width * 0.07,
      size.height * 0.25,
      size.width * 0.07,
      size.height * 0.45,
    );
    fPath.lineTo(size.width * 0.07, size.height * 0.95);
    fPath.lineTo(size.width * 0.25, size.height * 0.95);
    fPath.lineTo(size.width * 0.25, size.height * 0.85);
    fPath.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.7,
      size.width * 0.35,
      size.height * 0.7,
    );
    fPath.lineTo(size.width * 0.5, size.height * 0.7);
    fPath.lineTo(size.width * 0.5, size.height * 0.55);
    fPath.lineTo(size.width * 0.25, size.height * 0.55);
    fPath.lineTo(size.width * 0.25, size.height * 0.47);
    fPath.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.4,
      size.width * 0.4,
      size.height * 0.4,
    );
    fPath.lineTo(size.width * 0.5, size.height * 0.4);

    final iPath = Path();
    iPath.moveTo(size.width * 0.6, size.height * 0.57);
    iPath.lineTo(size.width * 0.8, size.height * 0.57);
    iPath.lineTo(size.width * 0.8, size.height * 0.7);
    iPath.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.77,
      size.width * 0.9,
      size.height * 0.77,
    );
    iPath.lineTo(size.width * 0.9, size.height * 0.95);
    iPath.lineTo(size.width * 0.77, size.height * 0.95);
    iPath.quadraticBezierTo(
      size.width * 0.6,
      size.height * 0.95,
      size.width * 0.6,
      size.height * 0.75,
    );

    canvas.drawPath(fPath, paintWord);
    canvas.drawPath(iPath, paintWord);

    var paintCircle = Paint()
      ..color = Colors.white.withOpacity(circleAlpha)
      ..style = PaintingStyle.fill;

    var paintSquare = Paint()
      ..color = Colors.white.withOpacity(squareAlpha)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.7, size.height * (heightRatio + 0.1)),
      10,
      paintCircle,
    );

    drawRotated(
      canvas,
      Offset(
        (size.width * .7),
        (size.height * (heightRatio + 0.1)),
      ),
      squareRotation * pi / 180,
      () => canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            (size.width * .6),
            (size.height * heightRatio),
            20,
            20,
          ),
          const Radius.circular(4),
        ),
        paintSquare,
      ),
    );
  }

  void drawRotated(
    Canvas canvas,
    Offset center,
    double angle,
    VoidCallback drawFunction,
  ) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);
    canvas.translate(-center.dx, -center.dy);
    drawFunction();
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
