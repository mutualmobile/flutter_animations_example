import 'package:flutter/material.dart';

class ContributorsCard extends StatelessWidget {
  final String imageUrl;
  final bool isAsset;
  final String name;
  final String email;
  final Color? textColor;

  const ContributorsCard({
    super.key,
    required this.imageUrl,
    this.isAsset = false,
    required this.name,
    required this.email,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 72,
            width: 72,
            child: isAsset
                ? Image.asset(
                    imageUrl,
                    fit: BoxFit.fill,
                  )
                : Image.network(
                    imageUrl,
                    fit: BoxFit.fill,
                  ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: textColor),
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              email,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: textColor),
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }
}
