import 'package:flutter/material.dart';

import '../contributors_card.dart';
import '../generated/assets.dart';

class DayNightAnimation extends StatefulWidget {
  const DayNightAnimation({super.key});

  @override
  State<DayNightAnimation> createState() => _DayNightAnimationState();
}

class _DayNightAnimationState extends State<DayNightAnimation> {
  bool isDay = true;
  double chainHeight = _chainInitialHeight;
  bool isHoldingHandle = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: _animationDuration,
      curve: _animationCurve,
      color: isDay ? _dayBGColor : _nightBGColor,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedContainer(
            width: _circleRadius,
            height: _circleRadius,
            duration: _animationDuration,
            curve: _animationCurve,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDay ? _sunColor : _moonColor,
            ),
          ),
          Transform.translate(
            offset: const Offset(-25, -25),
            child: AnimatedContainer(
              width: isDay ? 0 : _circleRadius,
              height: isDay ? 0 : _circleRadius,
              duration: _animationDuration,
              curve: _animationCurve,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDay ? _dayBGColor : _nightBGColor,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height / 2 + (_circleRadius / 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: isHoldingHandle
                      ? _chainHandleHoldDuration
                      : _chainHandleReleaseDuration,
                  curve: _chainHandleAnimationCurve,
                  height: chainHeight,
                  child: VerticalDivider(
                    color: isDay ? _sunColor : _moonColor,
                    thickness: _chainThickness,
                  ),
                ),
                GestureDetector(
                  onVerticalDragUpdate: (dragDetails) {
                    setState(() {
                      if (!isHoldingHandle) isHoldingHandle = true;
                      chainHeight += dragDetails.primaryDelta ?? 0;
                    });
                  },
                  onVerticalDragEnd: (_) => _updateAllStates(),
                  onVerticalDragCancel: () => _updateAllStates(),
                  child: Container(
                    width: _chainHandleRadius,
                    height: _chainHandleRadius,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDay ? _sunColor : _moonColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Padding(
              // bottom: 32 to avoid parent indicator positioned at bottom
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 32),
              child: ContributorsCard(
                imageUrl: Assets.shubham,
                isAsset: true,
                name: "Shubham Singh",
                email: "shubham.singh@mutualmobile.com",
                textColor: isDay ? _nightBGColor : _moonColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateAllStates() => setState(() {
        if (isHoldingHandle) isHoldingHandle = false;
        if (chainHeight > _chainInitialHeight * 1.5) isDay = !isDay;
        chainHeight = _chainInitialHeight;
      });
}

const _sunColor = Color(0xFFFABA50);
const _moonColor = Color(0xFFFFFFFF);
const _dayBGColor = Color(0xFFF8E6C2);
const _nightBGColor = Color(0xFF181818);
const _animationDuration = Duration(milliseconds: 700);
const _animationCurve = Curves.fastOutSlowIn;
const double _circleRadius = 120;
const double _chainInitialHeight = 80;
const double _chainThickness = 2;
const double _chainHandleRadius = 16;
const _chainHandleHoldDuration = Duration(seconds: 0);
const _chainHandleReleaseDuration = Duration(seconds: 1);
const _chainHandleAnimationCurve = Curves.elasticOut;
