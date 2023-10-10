import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../contributors_card.dart';

class RippleAnimationScreen extends StatefulWidget {
  const RippleAnimationScreen({super.key});

  @override
  RippleAnimationScreenState createState() => RippleAnimationScreenState();
}

class RippleAnimationScreenState extends State<RippleAnimationScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const RippleWaveAnimation(
      rippleColor: Color(0xFF01579B),
      childWidget: Padding(
        padding: EdgeInsets.all(12.0),
        child: Icon(
          Icons.mic,
          color: Colors.white,
        ),
      ),
    );
  }
}

class RippleCirclePainter extends CustomPainter {
  final Color color;
  final Animation<double> animation;

  RippleCirclePainter({required this.color, required this.animation})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    for (int rippleWave = 3; rippleWave >= 0; rippleWave--) {
      final value = rippleWave + animation.value;
      final double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
      final double radius =
          math.sqrt(((rect.width / 2) * (rect.width / 2)) * value / 4);
      final Paint paint = Paint()..color = color.withOpacity(opacity);
      canvas.drawCircle(rect.center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(RippleCirclePainter oldDelegate) {
    return true;
  }
}

class CustomCurveWave extends Curve {
  const CustomCurveWave();
  @override
  double transform(double t) {
    return t == 0 || t == 1 ? 0.01 : sin(t * pi);
  }
}

class RippleWaveAnimation extends StatefulWidget {
  const RippleWaveAnimation({
    super.key,
    this.rippleSize = 88.0,
    this.rippleColor = Colors.blueAccent,
    required this.childWidget,
  });
  final Widget childWidget;
  final Color rippleColor;
  final double rippleSize;
  @override
  RippleWaveAnimationState createState() => RippleWaveAnimationState();
}

class RippleWaveAnimationState extends State<RippleWaveAnimation>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool isReverseAnimationEnabled = true;
  final Tween<double> fadeTween = Tween(begin: 1.0, end: 0.2);
  final Tween<double> scaleTween = Tween(begin: 0.35, end: 1.0);
  @override
  Widget build(BuildContext context) {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: isReverseAnimationEnabled);
    return SafeArea(
        child: Material(
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: CustomPaint(
              painter: RippleCirclePainter(
                color: widget.rippleColor,
                animation: _animationController,
              ),
              child: SizedBox(
                width: widget.rippleSize * 5,
                height: widget.rippleSize * 5,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(widget.rippleSize),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: <Color>[
                            widget.rippleColor,
                            Color.lerp(widget.rippleColor, Colors.black, .04) ?? widget.rippleColor,
                          ],
                        ),
                      ),
                      child: FadeTransition(
                        opacity: fadeTween.animate(_animationController),
                        child: ScaleTransition(
                            scale: scaleTween.animate(
                              CurvedAnimation(
                                parent: _animationController,
                                curve: const CustomCurveWave(),
                              ),
                            ),
                            child: widget.childWidget),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 82,
          height: 100,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('enable reverse effect'),
                Switch(
                    value: isReverseAnimationEnabled,
                    onChanged: (value) {
                      setState(() {
                        isReverseAnimationEnabled = value;
                      });
                    })
              ],
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
                "https://ca.slack-edge.com/T02TLUWLZ-U03SFTW3QJ2-1b376cd1b981-512",
            name: "Pranay Patel",
            email: "pranay.patel@mutualmobile.com",
          ),
        ),
      ]),
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
