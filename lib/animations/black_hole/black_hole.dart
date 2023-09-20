import 'package:flutter/material.dart';

import '../../contributors_card.dart';

class BlackHole extends StatefulWidget {
  const BlackHole({super.key});

  @override
  State<BlackHole> createState() => _BlackHoleState();
}

class _BlackHoleState extends State<BlackHole> with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late Animation<double> _rotateAnimation;
  late Animation<double> _borderRadiusAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    //rotation animation controller
    _rotationController = getAnimationController(4);
    setAnimationListener(_rotationController);

    //scale animation controller
    _scaleController = getAnimationController(8);
    setAnimationListener(_scaleController);

    //rotation animation
    _rotateAnimation = Tween(begin: 0.0, end: 10.0)
        .animate(CurvedAnimation(parent: _rotationController, curve: Curves.easeInOut));
    //border radius animation
    _borderRadiusAnimation = Tween(begin: 150.0, end: 120.0)
        .animate(CurvedAnimation(parent: _rotationController, curve: Curves.easeInOut));
    //black hole scale animation
    _scaleAnimation = Tween(begin: 0.95, end: 2.0).animate(
        CurvedAnimation(parent: _scaleController, curve: Curves.bounceInOut));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(
                angle: _rotateAnimation.value + 0.2,
                child: Container(
                  width: 210,
                  height: 210,
                  decoration: BoxDecoration(
                      color: const Color(0xFF3B3449),
                      borderRadius: BorderRadius.all(
                        Radius.circular(_borderRadiusAnimation.value),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xFFBC0BFA).withOpacity(0.7),
                            offset: const Offset(0.0, -7.0),
                            blurRadius: 150.0,
                            blurStyle: BlurStyle.outer,
                            spreadRadius: 10),
                        BoxShadow(
                            color: const Color(0xFFBC0BFA).withOpacity(0.4),
                            offset: const Offset(0.0, 12.0),
                            blurRadius: 120.0,
                            blurStyle: BlurStyle.outer,
                            spreadRadius: 5),
                      ]),
                ),
              ),
              Transform.rotate(
                angle: _rotateAnimation.value * 2,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft:
                            Radius.circular(_borderRadiusAnimation.value + 10),
                        topRight:
                            Radius.circular(_borderRadiusAnimation.value - 2),
                        bottomLeft:
                            Radius.circular(_borderRadiusAnimation.value + 5),
                        bottomRight:
                            Radius.circular(_borderRadiusAnimation.value + 15),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xFFBC0BFA).withOpacity(0.8),
                            offset: const Offset(-6.0, -2.0),
                            blurRadius: 150.0,
                            blurStyle: BlurStyle.outer,
                            spreadRadius: 8),
                        BoxShadow(
                          color: const Color(0xFF383E3F).withOpacity(0.8),
                          offset: const Offset(-6.0, 7.0),
                        ),
                      ]),
                ),
              ),
              Transform.rotate(
                angle: -_rotateAnimation.value,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    width: 190,
                    height: 190,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft:
                              Radius.circular(_borderRadiusAnimation.value - 2),
                          topRight:
                              Radius.circular(_borderRadiusAnimation.value + 3),
                          bottomLeft:
                              Radius.circular(_borderRadiusAnimation.value - 5),
                          bottomRight:
                              Radius.circular(_borderRadiusAnimation.value - 7),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF000000).withOpacity(0.8),
                            offset: const Offset(-6.0, 10.0),
                          ),
                          BoxShadow(
                            color: const Color(0xFF000000).withOpacity(0.5),
                            offset: const Offset(10.0, 0.0),
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 32,
            height: 100,
            child: ContributorsCard(
              imageUrl:
                  "https://ca.slack-edge.com/T02TLUWLZ-UKMME8H8U-825b8f468eac-512",
              name: "Subir Chakraborty",
              email: "subir.chakraborty@mutualmobile.com",
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  AnimationController getAnimationController(int duration) {
    return AnimationController(
      vsync: this,
      duration: Duration(seconds: duration),
    );
  }

  void setAnimationListener(AnimationController controller) {
    controller
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      })
      ..forward();
  }
}
