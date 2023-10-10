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
  late Animation<double> _translateAnim;
  late Animation<double> _scaleAnim;
  static const double _centerPoint = 0.0;
  var iconPositions = <int>[0, 1, 2, 3];
  var buttonWidthList = <double>[150.0, 145.0];
  var buttonColorList = <Color>[const Color(0xFFFFED3D), Colors.pink];
  Color buttonColor = const Color(0xFFFFED3D);
  double buttonWidth = 150.0;
  bool isTapped = false;

  @override
  void initState() {
    super.initState();
    _translationController = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this)
      ..addListener(() => setState(() {}));
    _scaleController = AnimationController(
        duration: const Duration(milliseconds: 2700), vsync: this)
      ..addListener(() => setState(() {}));

    _translateAnim = Tween(begin: 0.0, end: 40.0).animate(CurvedAnimation(
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
            _centerPoint + (_translateAnim.value * 2),
            _centerPoint + (_translateAnim.value * 2),
            iconPositions[0],
            _scaleAnim.value,
          ),
          animatedWidget(
            _centerPoint + _translateAnim.value,
            _centerPoint + _translateAnim.value,
            iconPositions[1],
            _scaleAnim.value,
          ),
          animatedWidget(
            _centerPoint + (_translateAnim.value * 2),
            _centerPoint - (_translateAnim.value * 2),
            iconPositions[2],
            _scaleAnim.value,
          ),
          animatedWidget(
            _centerPoint + _translateAnim.value,
            _centerPoint - _translateAnim.value,
            iconPositions[3],
            _scaleAnim.value,
          ),
          animatedWidget(
            _centerPoint - (_translateAnim.value * 2),
            _centerPoint + (_translateAnim.value * 2),
            iconPositions[0],
            _scaleAnim.value,
          ),
          animatedWidget(
            _centerPoint - _translateAnim.value,
            _centerPoint + _translateAnim.value,
            iconPositions[2],
            _scaleAnim.value,
          ),
          animatedWidget(
            _centerPoint - (_translateAnim.value * 2),
            _centerPoint - (_translateAnim.value * 2),
            iconPositions[1],
            _scaleAnim.value,
          ),
          animatedWidget(
            _centerPoint - _translateAnim.value,
            _centerPoint - _translateAnim.value,
            iconPositions[3],
            _scaleAnim.value,
          ),
          animatedWidget(
            _centerPoint,
            _centerPoint - (_translateAnim.value * 2),
            iconPositions[1],
            _scaleAnim.value,
          ),
          animatedWidget(
            _centerPoint,
            _centerPoint + (_translateAnim.value * 2),
            iconPositions[3],
            _scaleAnim.value,
          ),
          animatedWidget(
            _centerPoint + (_translateAnim.value * 3),
            _centerPoint,
            iconPositions[0],
            _scaleAnim.value,
          ),
          animatedWidget(
            _centerPoint - (_translateAnim.value * 3),
            _centerPoint,
            iconPositions[2],
            _scaleAnim.value,
          ),
          Material(
            child: InkWell(
              onTap: () {
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
              },
              onTapDown: (TapDownDetails details) {
                setState(() {
                  buttonColor = buttonColorList.last;
                  buttonWidth = buttonWidthList.last;
                  isTapped = true;
                });
              },
              onTapUp: (TapUpDetails details) {
                setState(() {
                  buttonColor = buttonColorList.first;
                  buttonWidth = buttonWidthList.first;
                  isTapped = false;
                });
              },
              child: Container(
                  alignment: Alignment.center,
                  width: buttonWidth,
                  height: 34,
                  decoration: BoxDecoration(
                      color: buttonColor,
                      border: Border.all(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(6.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black87,
                          offset: Offset(-6.0, 6.0),
                        ),
                        BoxShadow(
                          color: Colors.black54,
                          offset: Offset(-7.0, 7.0),
                          blurRadius: 40.0,
                          blurStyle: BlurStyle.outer,
                        ),
                      ]),
                  child: buttonText(isTapped)),
            ),
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

Widget buttonText(bool isButtonDown) {
  if (isButtonDown) {
    return const Text(
      'Click to Celebrate',
      style: TextStyle(
          fontSize: 12.0, color: Colors.black, fontWeight: FontWeight.bold),
    );
  } else {
    return const Text(
      'Click to Celebrate',
      style: TextStyle(
          fontSize: 13.0, color: Colors.black, fontWeight: FontWeight.w400),
    );
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
