import 'dart:math';

import 'package:flutter/material.dart';

import '../../contributors_card.dart';

class AnimatedContainerScreen extends StatefulWidget {
  const AnimatedContainerScreen({Key? key}) : super(key: key);

  @override
  State<AnimatedContainerScreen> createState() =>
      _AnimatedContainerScreenState();
}

class _AnimatedContainerScreenState extends State<AnimatedContainerScreen> {
  double _shapeWidth = 20; // initial width of shape
  double _shapeHeight = 20; // initial height of shape
  Color _color = Colors.greenAccent; // initial color of shape
  late BorderRadiusGeometry _shapeBorderRadius; // initial border radius

  @override
  void initState() {
    super.initState();
    _shapeBorderRadius = BorderRadius.circular(8);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: [
        Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedContainer(
              duration: const Duration(seconds: 4), // Animation duration
              width: _shapeWidth,
              height: _shapeHeight,
              decoration: BoxDecoration(
                  borderRadius: _shapeBorderRadius, color: _color),
              curve: Curves.bounceInOut,
            ),
          ),
        ),
        FilledButton(
            onPressed: () {
              setState(() {
                //Using random generate values for height, width, colors and border radius that will be animate
                final random = Random();
                _shapeWidth = random.nextInt(1000).toDouble();
                _shapeHeight = random.nextInt(1000).toDouble();
                _color = Color.fromRGBO(random.nextInt(256),
                    random.nextInt(256), random.nextInt(256), 1);
                _shapeBorderRadius =
                    BorderRadius.circular(random.nextInt(200).toDouble());
              });
            }, // call start method to begin animation
            child: const Text('Start Animation')),
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
    );
  }
}
