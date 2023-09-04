import 'dart:math';

import 'package:flutter/material.dart';

import '../../contributors_card.dart';

class AnimatedSwitcherScreen extends StatefulWidget {
  const AnimatedSwitcherScreen({Key? key}) : super(key: key);

  @override
  State<AnimatedSwitcherScreen> createState() => _AnimatedSwitcherScreenState();
}

class _AnimatedSwitcherScreenState extends State<AnimatedSwitcherScreen> {
  bool isFavorite = false;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: [
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
color: Colors.white,
              child: Column(

                children: [
                  const SizedBox(height: 20,),
                  IconButton(
                    iconSize: 100,
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      icon: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Icon(
                          isFavorite ? Icons.star : Icons.star_border_outlined,
                          key: ValueKey(isFavorite),
                          color: Colors.blueAccent,
                        ),
                        transitionBuilder: (child, animation) {
                          return RotationTransition(
                            turns: Tween(begin: 0.6, end: 1.0).animate(animation),
                            child: child,
                          );
                        },
                      )),
                  const SizedBox(height: 12,),
                  const Text('Click on icon to see animation'),
                  const SizedBox(height: 12,),

                ],
              ),
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
    );
  }
}
