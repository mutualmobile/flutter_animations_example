import 'dart:math';

import 'package:flutter/material.dart';

class FlipCardWidget extends StatefulWidget {
  final Image front;
  final Image back;
  final double translateTo;

  const FlipCardWidget({
    required this.front,
    required this.back,
    required this.translateTo,
    super.key,
  });

  @override
  State<FlipCardWidget> createState() => _FlipCardWidgetState();
}

class _FlipCardWidgetState extends State<FlipCardWidget>
    with TickerProviderStateMixin {
  late AnimationController _translationController;
  late AnimationController _controller;
  late Animation<double> _translateAnimation;
  late Animation<double> _animation;
  bool isFront = false;
  bool isResting = false;
  double dragPosition = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {
          dragPosition = _animation.value;
          setImageSide();
        });
      });

    _translationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 750))
      ..addListener(() {
        setState(() {});
      })
      ..forward();

    // translate animation
    _translateAnimation = Tween<double>(
      begin: 0.0,
      end: -widget.translateTo,
    ).animate(
        CurvedAnimation(parent: _translationController, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rotationAngle = dragPosition / 180 * pi;
    final transform = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateY(rotationAngle);
    return Transform.translate(
      offset: Offset(0.0, _translateAnimation.value),
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (!isResting) {
            setState(() {
              dragPosition -= details.delta.dx;
              dragPosition %= 360;
              setImageSide();
            });
          }
        },
        onHorizontalDragEnd: (details) {
          if (!isResting) {
            double endPosition = isFront ? (dragPosition > 180 ? 360 : 0) : 180;
            _animation = Tween<double>(
              begin: dragPosition,
              end: endPosition,
            ).animate(_controller);
            _controller.forward(from: 0);
          }
        },
        onVerticalDragUpdate: (details) {
          if (details.delta.dy >= 5) {
            _translationController.reverse();
            isResting = true;
          } else {
            _translationController.forward();
            isResting = false;
          }
        },
        child: Transform(
          transform: transform,
          alignment: Alignment.center,
          child: isFront ? widget.back : widget.front,
        ),
      ),
    );
  }

  void setImageSide() {
    if (dragPosition <= 90 || dragPosition >= 270) {
      isFront = false;
    } else {
      isFront = true;
    }
  }
}
