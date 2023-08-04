import 'package:flutter/material.dart';

import '../../contributors_card.dart';

class FiSplashScreen extends StatefulWidget {
  const FiSplashScreen({super.key});

  @override
  State<FiSplashScreen> createState() => _FiSplashScreenState();
}

class _FiSplashScreenState extends State<FiSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: const CircleAvatar(
            backgroundColor: Colors.white,
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
}

class FiIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
