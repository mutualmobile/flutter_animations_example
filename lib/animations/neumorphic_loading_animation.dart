import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../contributors_card.dart';
import '../generated/assets.dart';

class NeumorphismButtonGrid extends StatefulWidget {
  const NeumorphismButtonGrid({super.key});

  @override
  State<NeumorphismButtonGrid> createState() => _NeumorphismButtonGridState();
}

class _NeumorphismButtonGridState extends State<NeumorphismButtonGrid> {
  List<Size> buttonSizes = [];
  List<bool> buttonPressedStates = [];

  late Timer randomButtonPressTimer;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 20; i++) {
      double size = Random().nextInt(20).toDouble() + 20;
      buttonSizes.add(Size(size, size));
      buttonPressedStates.add(false);
    }

    randomButtonPressTimer =
        Timer.periodic(const Duration(milliseconds: 10), (timer) {
      int randomIndex = Random().nextInt(buttonPressedStates.length);
      setState(() {
        buttonPressedStates[randomIndex] = !buttonPressedStates[randomIndex];
      });
    });
  }

  @override
  void dispose() {
    randomButtonPressTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: buttonSizes.length,
        itemBuilder: (BuildContext context, int index) {
          return NeumorphismButton(
            key: ValueKey<int>(index),
            initialSize: buttonSizes[index],
            isPressed: buttonPressedStates[index],
          );
        },
      ),
      const Positioned(
        left: 0,
        right: 0,
        bottom: 32,
        height: 100,
        child: ContributorsCard(
          imageUrl: Assets.yugesh,
          isAsset: true,
          name: "Yugesh Jain",
          email: "yugesh.jain@mutualmobile.com",
          textColor: Colors.black,
        ),
      )
    ]);
  }
}

class NeumorphismButton extends StatefulWidget {
  final Size initialSize;
  final bool isPressed;

  const NeumorphismButton({
    Key? key,
    required this.initialSize,
    required this.isPressed,
  }) : super(key: key);

  @override
  State<NeumorphismButton> createState() => _NeumorphismButtonState();
}

class _NeumorphismButtonState extends State<NeumorphismButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: widget.initialSize.height,
              width: widget.initialSize.width,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(50),
                boxShadow: widget.isPressed
                    ? [
                        BoxShadow(
                          color: Colors.grey[500]!,
                          offset: const Offset(4, 4),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                        const BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4, -4),
                          blurRadius: 15,
                          spreadRadius: 1,
                        )
                      ]
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
