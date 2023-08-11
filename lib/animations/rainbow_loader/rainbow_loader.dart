import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

import '../../contributors_card.dart';

class RainbowLoader extends StatefulWidget {
  const RainbowLoader({super.key});

  @override
  State<RainbowLoader> createState() => _RainbowLoaderState();
}

class _RainbowLoaderState extends State<RainbowLoader>
    with SingleTickerProviderStateMixin {
  final PanelController panelController = PanelController();
  double panelProgress = 0.0;
  final listViewItems = const [
    _ListViewItemEntry('Tubik Studio', 'Santa Cruz Mountains, California'),
    _ListViewItemEntry('Tubik Studio', 'Santa Cruz Mountains, California'),
    _ListViewItemEntry('Malibu, California', 'Malibu'),
    _ListViewItemEntry('Palo Alto, California', 'Palo Alto'),
    _ListViewItemEntry('San Diego, California', 'San Diego'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: _rainbowRed,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.viewPaddingOf(context).top,
            child: Stack(
              alignment: Alignment.center,
              children: [
                _AnimatedColorStatusBar(
                  startAnimation: panelProgress > 0.1,
                  color: _rainbowGreen,
                  delayOffset: const Duration(milliseconds: 0),
                ),
                _AnimatedColorStatusBar(
                  startAnimation: panelProgress > 0.1,
                  color: _rainbowBlue,
                  delayOffset: const Duration(milliseconds: 300),
                ),
                _AnimatedColorStatusBar(
                  startAnimation: panelProgress > 0.1,
                  color: _rainbowYellow,
                  delayOffset: const Duration(milliseconds: 600),
                ),
                _AnimatedColorStatusBar(
                  startAnimation: panelProgress > 0.1,
                  color: _rainbowRed,
                  delayOffset: const Duration(milliseconds: 900),
                ),
              ],
            ),
          ),
          Flexible(
            child: SlidingUpPanel(
              controller: panelController,
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 156,
                  horizontal: 32,
                ),
                child: ListView.builder(
                  itemCount: listViewItems.length,
                  itemBuilder: (context, index) {
                    final item = listViewItems[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Opacity(
                        opacity: 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(item.subtitle),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              minHeight: 160,
              maxHeight: 290,
              boxShadow: null,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(56),
                bottomRight: Radius.circular(56),
              ),
              color: _rainbowRed,
              backdropEnabled: true,
              backdropColor: Colors.white,
              backdropOpacity: 0.6,
              slideDirection: SlideDirection.DOWN,
              parallaxEnabled: true,
              panelBuilder: () => Column(
                verticalDirection: VerticalDirection.up,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Transform.rotate(
                      angle: pi * panelProgress,
                      child: InkWell(
                        onTap: () => panelController.animatePanelToPosition(
                          1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn,
                        ),
                        splashFactory: NoSplash.splashFactory,
                        child: const Icon(
                          Icons.keyboard_arrow_down,
                          size: 36,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      bottom: 24,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Opacity(
                        opacity: 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                top: 6,
                                bottom: 6,
                                right: 2,
                              ),
                              child: Icon(Icons.search, size: 16),
                            ),
                            Text(
                              'Search',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 24,
                        bottom: 8 + (72 * panelProgress),
                      ),
                      child: const Text(
                        'Locations',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 32,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              onPanelSlide: (progress) {
                setState(() => panelProgress = progress);
                if (progress == 1 && !panelController.isPanelAnimating) {
                  Future.delayed(const Duration(seconds: 1), () {
                    panelController.animatePanelToPosition(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: const Cubic(.86, .03, .83, .67),
                    );
                  });
                }
              },
            ),
          ),
          const Padding(
            // bottom: 32 to avoid parent indicator positioned at bottom
            padding: EdgeInsets.only(left: 8, right: 8, bottom: 32),
            child: ContributorsCard(
              imageUrl:
                  "https://ca.slack-edge.com/T02TLUWLZ-U02BR1HSNS2-59c1dffa5a83-512",
              name: "Shubham Singh",
              email: "shubham.singh@mutualmobile.com",
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedColorStatusBar extends StatefulWidget {
  final bool startAnimation;
  final Color color;
  final Duration delayOffset;

  const _AnimatedColorStatusBar({
    required this.startAnimation,
    required this.color,
    required this.delayOffset,
  });

  @override
  State<_AnimatedColorStatusBar> createState() =>
      _AnimatedColorStatusBarState();
}

class _AnimatedColorStatusBarState extends State<_AnimatedColorStatusBar>
    with SingleTickerProviderStateMixin {
  double currentWidth = 0;
  late AnimationController animationController;

  void onAnimationControllerProgress() {
    setState(() {
      currentWidth =
          (MediaQuery.of(context).size.width * animationController.value);
    });
  }

  @override
  void initState() {
    animationController = AnimationController(vsync: this);
    animationController.addListener(onAnimationControllerProgress);
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(
          const Duration(milliseconds: 300),
          () => animationController.value = 0,
        );
      }
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _AnimatedColorStatusBar oldWidget) {
    final didUpdate = oldWidget.startAnimation != widget.startAnimation &&
        widget.startAnimation;

    if (didUpdate) {
      animationController.value = 0;
      Future.delayed(widget.delayOffset, () {
        animationController.animateTo(1, duration: const Duration(seconds: 1));
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    animationController.removeListener(onAnimationControllerProgress);
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scaleX: 1.1,
      child: Container(
        width: currentWidth,
        height: MediaQuery.viewPaddingOf(context).top,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
    );
  }
}

class _ListViewItemEntry {
  final String title, subtitle;

  const _ListViewItemEntry(this.title, this.subtitle);
}

const Color _rainbowRed = Color(0xFFFF526B);
const Color _rainbowGreen = Color(0xFF28FFBD);
const Color _rainbowBlue = Color(0xFF42A0EE);
const Color _rainbowYellow = Color(0xFFFFDE39);
