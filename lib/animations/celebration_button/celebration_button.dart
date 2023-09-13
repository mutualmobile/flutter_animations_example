import 'package:flutter/material.dart';

import '../../contributors_card.dart';

class CelebrationButton extends StatefulWidget {
  const CelebrationButton({super.key});

  @override
  State<CelebrationButton> createState() => _CelebrationButtonState();
}

class _CelebrationButtonState extends State<CelebrationButton>
    with TickerProviderStateMixin {
  late AnimationController _translationController;
  late AnimationController _scaleController;
  late Animation<double> _translateAnim1;
  late Animation<double> _translateAnim2;
  late Animation<double> _translateAnim3;
  late Animation<double> _scaleAnim;
  static const double _centerPoint = 0.0;
  var iconPositions = <int>[0, 1, 2, 3];

  @override
  void initState() {
    super.initState();
    _translationController = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this)
      ..addListener(() => setState(() {}));
    _scaleController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this)
      ..addListener(() => setState(() {}));

    _translateAnim1 = Tween(begin: 0.0, end: 90.0).animate(CurvedAnimation(
        parent: _translationController, curve: Curves.fastOutSlowIn));
    _translateAnim2 = Tween(begin: 0.0, end: 45.0).animate(CurvedAnimation(
        parent: _translationController, curve: Curves.fastOutSlowIn));
    _translateAnim3 = Tween(begin: 0.0, end: 120.0).animate(CurvedAnimation(
        parent: _translationController, curve: Curves.fastOutSlowIn));
    _scaleAnim = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _scaleController, curve: Curves.fastOutSlowIn));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAFAFA),
      child: Stack(
        alignment: Alignment.center,
        children: [
          animatedWidget(
            _centerPoint + _translateAnim1.value,
            _centerPoint + _translateAnim1.value,
            iconPositions[0],
            _scaleAnim.value,
          ),
          animatedWidget(
            _centerPoint + _translateAnim2.value,
            _centerPoint + _translateAnim2.value,
            iconPositions[1],
            _scaleAnim.value,
          ),
          animatedWidget(
            _centerPoint + _translateAnim1.value,
            _centerPoint - _translateAnim1.value,
            iconPositions[2],
            _scaleAnim.value,
          ),
          animatedWidget(
            _centerPoint + _translateAnim2.value,
            _centerPoint - _translateAnim2.value,
            iconPositions[3],
            _scaleAnim.value,
          ),
          animatedWidget(
            _centerPoint - _translateAnim1.value,
            _centerPoint + _translateAnim1.value,
            iconPositions[0],
            _scaleAnim.value,
          ),
          animatedWidget(
            _centerPoint - _translateAnim2.value,
            _centerPoint + _translateAnim2.value,
            iconPositions[2],
            _scaleAnim.value,
          ),
          animatedWidget(
            _centerPoint - _translateAnim1.value,
            _centerPoint - _translateAnim1.value,
            iconPositions[1],
            _scaleAnim.value,
          ),
          animatedWidget(
            _centerPoint - _translateAnim2.value,
            _centerPoint - _translateAnim2.value,
            iconPositions[3],
            _scaleAnim.value,
          ),
          animatedWidget(
            _centerPoint,
            _centerPoint - _translateAnim1.value,
            iconPositions[1],
            _scaleAnim.value,
          ),
          animatedWidget(
            _centerPoint,
            _centerPoint + _translateAnim1.value,
            iconPositions[3],
            _scaleAnim.value,
          ),
          animatedWidget(
            _centerPoint + _translateAnim3.value,
            _centerPoint,
            iconPositions[0],
            _scaleAnim.value,
          ),
          animatedWidget(
            _centerPoint - _translateAnim3.value,
            _centerPoint,
            iconPositions[2],
            _scaleAnim.value,
          ),
          FilledButton(
              onPressed: () {
                if (_translationController.isCompleted) {
                  iconPositions.shuffle();
                  _translationController.reset();
                  _translationController.forward();
                  _scaleController.reset();
                  _scaleController.forward();
                } else {
                  _translationController.forward();
                  _scaleController.forward();
                }
              }, // call start method to begin animation
              child: const Text('Click to Celebrate')),
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
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _translationController.dispose();
    super.dispose();
  }
}

Widget animatedWidget(
  double xValue,
  double yValue,
  int itemPosition,
  double scaleValue,
) {
  return Transform.translate(
    offset: Offset(xValue, yValue),
    child:
        Transform.scale(scale: scaleValue, child: confettiImages[itemPosition]),
  );
}

var confettiImages = [
  Image.asset(
    "assets/images/party.png",
    width: 30,
    height: 30,
  ),
  Image.asset(
    "assets/images/circle.png",
    width: 20,
    height: 20,
  ),
  Image.asset(
    "assets/images/hash.png",
    width: 22,
    height: 22,
  ),
  Image.asset(
    "assets/images/square.png",
    width: 20,
    height: 20,
  ),
];
