import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'animations/celebration_button/celebration_button.dart';
import 'animations/circle_square/circle_square.dart';
import 'animations/animated_container/animated_container.dart';
import 'animations/crazy_squares/square_container_animation.dart';
import 'animations/day_night.dart';
import 'animations/fab_menu/fab_menu.dart';
import 'animations/rainbow_loader/rainbow_loader.dart';
import 'animations/fi_splash/fi_splash.dart';
import 'animations/ripple_wave/ripple_wave.dart';
import 'animations/twitter_splash/twitter_splash.dart';
import 'animations/animated_switcher/animated_switcher.dart';
import 'animations/slider_animation.dart';
import 'animations/neumorphic_loading_animation.dart';

void main() {
  makeStatusBarTransparent();
  runApp(const MyApp());
}

void makeStatusBarTransparent() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimationsCarousel(),
    );
  }
}

class AnimationsCarousel extends StatefulWidget {
  const AnimationsCarousel({super.key});

  @override
  State<AnimationsCarousel> createState() => _AnimationsCarouselState();
}

class _AnimationsCarouselState extends State<AnimationsCarousel> {
  final PageController _pageController = PageController(initialPage: 0);

  int _activePage = 0;

  final List<Widget> _animationsList = [
    const TwitterSplashScreen(),
    const CircleSquareAnimation(),
    const RainbowLoader(),
    const AnimatedContainerScreen(),
    const FiSplashScreen(),
    const DayNightAnimation(),
    const RippleAnimationScreen(),
    const SquareContainerAnimation(),
    const AnimatedSwitcherScreen(),
    const FABMenuAnimation(),
    const SliderAnimation(),
    const SquareContainerAnimation(),
    const NeumorphismButtonGrid(),
    const CelebrationButton(),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _activePage = page;
            });
          },
          itemCount: _animationsList.length,
          itemBuilder: (BuildContext context, int index) {
            return _animationsList[index % _animationsList.length];
          },
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 32,
          child: Container(
            color: Colors.black54,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                  _animationsList.length,
                  (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor:
                              _activePage == index ? Colors.amber : Colors.grey,
                        ),
                      )),
            ),
          ),
        ),
      ],
    );
  }
}
