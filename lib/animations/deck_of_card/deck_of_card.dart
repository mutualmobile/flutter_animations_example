import 'package:flutter/material.dart';

import '../../contributors_card.dart';
import 'flip_card_widget.dart';

class DeckOfCard extends StatefulWidget {
  const DeckOfCard({super.key});

  @override
  State<DeckOfCard> createState() => _DeckOfCardState();
}

class _DeckOfCardState extends State<DeckOfCard> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        //background
        Image.asset(
          height: screenHeight,
          width: screenWidth,
          "assets/images/texture_green.png",
          repeat: ImageRepeat.repeat,
        ),
        //box back side
        Container(
          height: screenHeight / 2.9,
          width: screenWidth / 2,
          color: Colors.white,
        ),
        //box shadow
        Positioned(
          left: screenWidth / 2 + (screenWidth / 2) / 2,
          height: screenHeight / 3.5,
          width: 10,
          child: ClipPath(
            clipper: CornerCutoutClipper(),
            child: Container(
              color: Colors.black87,
            ),
          ),
        ),
        FlipCardWidget(
          front: Image.asset(
              width: screenWidth / 2.05,
              fit: BoxFit.fitWidth,
              "assets/images/card_front.png"),
          back: Image.asset(
              width: screenWidth / 2.05,
              fit: BoxFit.fitWidth,
              "assets/images/card_back.png"),
          translateTo: screenHeight / 2.8,
        ),
        //box
        Positioned(
          height: screenHeight / 3.5,
          width: screenWidth / 2,
          child: ClipPath(
            clipper: CenterCutoutClipper(),
            child: Image.asset(
              "assets/images/patterns.png",
              repeat: ImageRepeat.repeat,
            ),
          ),
        ),
        //credit
        const Positioned(
          left: 0,
          right: 0,
          top: 20,
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
    );
  }
}

class CenterCutoutClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.lineTo((size.width / 2) + 24, 0.0);
    path.arcToPoint(
      Offset((size.width / 2) - 24, 0.0),
      radius: const Radius.circular(24.0),
      clockwise: true,
    );
    path.lineTo(0.0, 0.0);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CornerCutoutClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, size.height);
    path.lineTo(size.width, 20.0);
    path.lineTo(0.0, 0.0);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
