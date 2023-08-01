import 'package:flutter/material.dart';

import 'animations/twitter_splash/twitter_splash.dart';

void main() {
  runApp(const MyApp());
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
                      backgroundColor: _activePage == index
                          ? Colors.amber
                          : Colors.grey,
                    ),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}

