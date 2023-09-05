import 'dart:math';

import 'package:flutter/material.dart';

import '../../contributors_card.dart';

class AnimatedSwitcherScreen extends StatefulWidget {
  const AnimatedSwitcherScreen({Key? key}) : super(key: key);

  @override
  State<AnimatedSwitcherScreen> createState() => _AnimatedSwitcherScreenState();
}

class _AnimatedSwitcherScreenState extends State<AnimatedSwitcherScreen> {
  late bool _isFavorite;
  late bool _isRotated;
  late int _currentIndex;

  late List<Widget> widgets;

  @override
  void initState() {
    super.initState();
    _isFavorite = false;
    _isRotated = false;
    _currentIndex = 0;
    widgets = [
      Image.asset(
        'assets/images/pic1.jpg',
        fit: BoxFit.fill,
        key: const Key('1'),
        width: 200,
        height: 200,
      ),
      Image.asset(
        'assets/images/pic2.jpg',
        fit: BoxFit.fill,
        key: const Key('2'),
        height: 200,
        width: 200,
      ),
      Image.asset(
        'assets/images/pic3.jpg',
        fit: BoxFit.fill,
        key: const Key('3'),
        height: 200,
        width: 200,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: [
        Container(
          width: double.infinity,
          alignment: Alignment.topCenter,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    const Text('Click on any widget to see an animation'),
                    const SizedBox(
                      height: 12,
                    ),
                    IconButton(
                        iconSize: 100,
                        onPressed: () {
                          setState(() {
                            _isFavorite = !_isFavorite;
                          });
                        },
                        icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Icon(
                            _isFavorite
                                ? Icons.star
                                : Icons.star_border_outlined,
                            key: ValueKey(_isFavorite),
                            color: Colors.blueAccent,
                          ),
                          transitionBuilder: (child, animation) {
                            return RotationTransition(
                              turns: Tween(begin: 0.6, end: 1.0)
                                  .animate(animation),
                              child: child,
                            );
                          },
                        )),
                    const Divider(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        final isLastIndex = _currentIndex == widgets.length - 1;

                        setState(() => _currentIndex =
                            isLastIndex ? 0 : _currentIndex + 1);
                      },
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 2000),
                          reverseDuration: const Duration(milliseconds: 5000),
                          transitionBuilder: (child, animation) =>
                              ScaleTransition(
                            scale: animation,
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      15), // Adjust the radius as needed
                                ),
                                clipBehavior: Clip.antiAlias,
                                elevation: 5.0,
                                child: child),
                          ),
                          // switchInCurve: Curves.bounceIn,
                          // switchOutCurve: Curves.bounceOut,
                          switchInCurve: Curves.fastLinearToSlowEaseIn,
                          switchOutCurve: Curves.fastEaseInToSlowEaseOut,
                          child: widgets[_currentIndex],
                        ),
                      ),
                    ),
                    const Divider(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isRotated = !_isRotated;
                        });
                      },
                      child: AnimatedSwitcher(
                        duration: const Duration(seconds: 1),
                        transitionBuilder: (child, animation) {
                          final rotate =
                              Tween(begin: pi, end: 0.0).animate(animation);
                          return AnimatedBuilder(
                              animation: rotate,
                              child: child,
                              builder: (BuildContext context, Widget? child) {
                                final angle =
                                    (ValueKey(_isRotated) != widget.key)
                                        ? min(rotate.value, pi / 2)
                                        : rotate.value;
                                return Transform(
                                  transform: Matrix4.rotationY(
                                      angle), // Use rotationX for vertical rotate
                                  alignment: Alignment.center,
                                  child: child,
                                );
                              });
                        },
                        switchInCurve: Curves.easeInCubic,
                        switchOutCurve: Curves.easeOutCubic,
                        child: _isRotated ? _frontCard() : _rearCard(),
                      ),
                    ),
                  ],
                ),
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

  Widget _frontCard() {
    return Container(
      width: 150,
      height: 150,
      key: const ValueKey(true),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(colors: [
            Colors.red.withOpacity(0.55),
            Colors.red.withOpacity(0.9)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: Center(
        child: Text(
          'Front',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
    );
  }

  Widget _rearCard() {
    return Container(
      width: 150,
      height: 150,
      key: const ValueKey(false),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(colors: [
            Colors.lightGreen.withOpacity(0.55),
            Colors.lightGreen.withOpacity(0.9)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: Center(
        child: Text(
          'Rear',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
    );
  }
}
