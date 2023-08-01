import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../contributors_card.dart';

class TwitterSplashScreen extends StatefulWidget {
  const TwitterSplashScreen({super.key});

  @override
  State<TwitterSplashScreen> createState() => _TwitterSplashScreenState();
}

class _TwitterSplashScreenState extends State<TwitterSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleValue;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 7));
    _scaleValue = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem(
            tween: Tween<double>(begin: 1.0, end: 1.5)
                .chain(CurveTween(curve: Curves.fastEaseInToSlowEaseOut)),
            weight: 1),
        TweenSequenceItem(
            tween: Tween<double>(begin: 1.5, end: 1.0)
                .chain(CurveTween(curve: Curves.fastEaseInToSlowEaseOut)),
            weight: 1),
        TweenSequenceItem(
            tween: Tween<double>(begin: 1.0, end: 1.5)
                .chain(CurveTween(curve: Curves.fastEaseInToSlowEaseOut)),
            weight: 1),
        TweenSequenceItem(
            tween: Tween<double>(begin: 1.0, end: 160.0)
                .chain(CurveTween(curve: Curves.fastEaseInToSlowEaseOut)),
            weight: 1),
        TweenSequenceItem(tween: ConstantTween<double>(160.0), weight: .5),
      ],
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: const Color(0xFF50abf1),
          child: Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleValue.value,
                  child: Image.asset(
                    "assets/images/twitter.png",
                    width: 40,
                    height: 40,
                  ),
                );
              },
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
                "https://ca.slack-edge.com/T02TLUWLZ-U02CDNRLMSA-4aa8ad906c93-72",
            name: "Aditya Bhawsar",
            email: "aditya.bhawsar@mutualmobile.com",
          ),
        ),
      ],
    );
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }
}
