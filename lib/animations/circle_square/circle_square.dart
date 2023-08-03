import 'dart:math';

import 'package:flutter/material.dart';

import '../../contributors_card.dart';

class CircleSquareAnimation extends StatefulWidget {
  const CircleSquareAnimation({super.key});

  @override
  State<CircleSquareAnimation> createState() => _CircleSquareAnimationState();
}

class _CircleSquareAnimationState extends State<CircleSquareAnimation>
    with TickerProviderStateMixin {
  late AnimationController _rotateSquareController;
  late Animation<double> _rotateSquareValue;

  late AnimationController _rotateCircleController;
  late Animation<double> _rotateCircleValue;

  @override
  void initState() {
    super.initState();
    _rotateSquareController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3500));

    _rotateSquareValue = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem(tween: ConstantTween<double>(0.0), weight: 1),
        TweenSequenceItem(
            tween: Tween<double>(begin: 0.0, end: 90.0)
                .chain(CurveTween(curve: Curves.fastOutSlowIn)),
            weight: 1),
        TweenSequenceItem(tween: ConstantTween<double>(90.0), weight: .5),
        TweenSequenceItem(
            tween: Tween<double>(begin: 90.0, end: 0.0)
                .chain(CurveTween(curve: Curves.fastOutSlowIn)),
            weight: 1),
      ],
    ).animate(
      CurvedAnimation(
        parent: _rotateSquareController,
        curve: Curves.linear,
      ),
    );

    _rotateCircleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3500));

    _rotateCircleValue = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem(tween: ConstantTween<double>(0.0), weight: 1),
        TweenSequenceItem(tween: ConstantTween<double>(0.0), weight: 1),
        TweenSequenceItem(tween: ConstantTween<double>(0.0), weight: .5),
        TweenSequenceItem(
            tween: Tween<double>(begin: 0.0, end: 360.0)
                .chain(CurveTween(curve: Curves.fastOutSlowIn)),
            weight: 1),
      ],
    ).animate(
      CurvedAnimation(
        parent: _rotateSquareController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _rotateSquareController.repeat();
    _rotateCircleController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: AnimatedBuilder(
              animation: _rotateSquareController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotateSquareValue.value * pi / 180,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnimatedBuilder(
                              animation: _rotateCircleController,
                              builder: (context, child) {
                                return Transform.rotate(
                                  angle: _rotateCircleValue.value * pi / 180,
                                  child: CustomPaint(
                                    size: const Size(120, 120),
                                    painter: ThreeQuarterCirclePainter(4),
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnimatedBuilder(
                              animation: _rotateCircleController,
                              builder: (context, child) {
                                return Transform.rotate(
                                  angle: _rotateCircleValue.value * pi / 180,
                                  child: CustomPaint(
                                    size: const Size(120, 120),
                                    painter: ThreeQuarterCirclePainter(3),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnimatedBuilder(
                              animation: _rotateCircleController,
                              builder: (context, child) {
                                return Transform.rotate(
                                  angle: _rotateCircleValue.value * pi / 180,
                                  child: CustomPaint(
                                    size: const Size(120, 120),
                                    painter: ThreeQuarterCirclePainter(1),
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnimatedBuilder(
                              animation: _rotateCircleController,
                              builder: (context, child) {
                                return Transform.rotate(
                                  angle: _rotateCircleValue.value * pi / 180,
                                  child: CustomPaint(
                                    size: const Size(120, 120),
                                    painter: ThreeQuarterCirclePainter(2),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
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
          child: Card(
            child: ContributorsCard(
              imageUrl:
              "https://ca.slack-edge.com/T02TLUWLZ-U02CDNRLMSA-4aa8ad906c93-72",
              name: "Aditya Bhawsar",
              email: "aditya.bhawsar@mutualmobile.com",
            ),
          ),
        )
      ],
    );
  }
}

class ThreeQuarterCirclePainter extends CustomPainter {
  final int missingQuadrant;

  ThreeQuarterCirclePainter(this.missingQuadrant);

  @override
  void paint(Canvas canvas, Size size) {
    var paintCircle = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(
        size.width / 2,
        size.height / 2,
      ),
      size.width / 2,
      paintCircle,
    );

    var paintSquare = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    canvas.drawRect(_getRectForMissingQuadrant(size), paintSquare);
  }

  Rect _getRectForMissingQuadrant(Size size) {
    switch (missingQuadrant % 4) {
      case 1:
        return Rect.fromLTRB(size.width / 2, 0, size.width, size.height / 2);
      case 2:
        return Rect.fromLTRB(0, 0, size.width / 2, size.height / 2);
      case 3:
        return Rect.fromLTRB(0, size.height / 2, size.width / 2, size.height);
      default:
        return Rect.fromLTRB(
            size.width / 2, size.height / 2, size.width, size.height);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
