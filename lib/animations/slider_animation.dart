import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../contributors_card.dart';
import '../../generated/assets.dart';

class SliderAnimation extends StatefulWidget {
  const SliderAnimation({Key? key}) : super(key: key);

  @override
  State<SliderAnimation> createState() => _SliderAnimationState();
}

class _SliderAnimationState extends State<SliderAnimation> {
  late PageController _pageController;
  List<Artist> artists = [];
  int currentIndex = 0;
  double pageValue = 0.0;

  @override
  void initState() {
    super.initState();
    artists = rawData
        .map(
          (data) => Artist(
            index: data["index"],
            image: data["image"],
          ),
        )
        .toList();
    _pageController = PageController(
      initialPage: currentIndex,
      viewportFraction: 0.8,
    )..addListener(() {
        setState(() {
          pageValue = _pageController.page!;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    final reversedArtistList = artists.reversed.toList();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
      child: Stack(
        children: <Widget>[
          Stack(
            children: reversedArtistList.map((artist) {
              return ImageSlider(
                pageValue: pageValue,
                image: artist.image,
                index: artist.index - 1,
              );
            }).toList(),
          ),
          AnimatedPages(
            pageValue: pageValue,
            pageController: _pageController,
            pageCount: artists.length,
            pageChangeCallback: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            child: (index, _) => ArtistCard(artists[index], index),
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
              textColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

class ArtistCard extends StatelessWidget {
  final Artist artist;
  final int index;

  const ArtistCard(this.artist, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        50.0,
        index == 0 ? 190.0 : 150.0,
        50.0,
        index == rawData.length ? 150.0 : 190.0,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 12.0,
              spreadRadius: 4.0),
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(32),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          child: Image.asset(
            artist.image,
            height: 290,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class ImageSlider extends StatelessWidget {
  final int index;
  final String image;
  final double pageValue;

  const ImageSlider({
    Key? key,
    required this.index,
    required this.image,
    required this.pageValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ImageClipper(progress: getProgress()),
      child: Image.asset(
        image,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  double getProgress() {
    if (index == pageValue.floor()) {
      return 1.0 - (pageValue - index);
    } else if (index < pageValue.floor()) {
      return 0.0;
    } else {
      return 1.0;
    }
  }
}

class ImageClipper extends CustomClipper<Path> {
  ImageClipper({required this.progress});

  final double progress;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addRect(
      Rect.fromLTRB(
        size.width - (size.width * progress),
        0,
        size.width,
        size.height,
      ),
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

typedef ChildBuilder = Widget Function(int index, BuildContext context);
typedef OnPageChangeCallback = void Function(int index);

class AnimatedPages extends StatelessWidget {
  final PageController pageController;
  final double pageValue;
  final ChildBuilder child;
  final int pageCount;
  final OnPageChangeCallback pageChangeCallback;

  const AnimatedPages({
    Key? key,
    required this.pageController,
    required this.pageValue,
    required this.child,
    required this.pageCount,
    required this.pageChangeCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        onPageChanged: pageChangeCallback,
        physics: const ClampingScrollPhysics(),
        controller: pageController,
        itemCount: pageCount,
        itemBuilder: (context, index) {
          if (index == pageValue.floor() + 1 ||
              index == pageValue.floor() + 2) {
            return Transform.translate(
              offset: Offset(0.0, 100 * (index - pageValue)),
              child: child(index, context),
            );
          } else if (index == pageValue.floor() ||
              index == pageValue.floor() - 1) {
            return Transform.translate(
              offset: Offset(0.0, 100 * (pageValue - index)),
              child: child(index, context),
            );
          } else {
            return child(index, context);
          }
        },
      ),
    );
  }
}

class Artist {
  final String image;
  final int index;

  Artist({
    required this.index,
    required this.image,
  });
}

List<Map<String, dynamic>> rawData = [
  {
    'image': 'assets/images/marshmello.png',
    'index': 1,
  },
  {
    'image': 'assets/images/drake.png',
    'index': 2,
  },
  {
    'image': 'assets/images/billieeilish.png',
    'index': 3,
  },
  {
    'image': 'assets/images/eminem.png',
    'index': 4,
  },
];
