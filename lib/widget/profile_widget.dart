import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../styles/theme_data.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key? key,
    this.isOnline = false,
    this.onlineColor = Colors.white,
    this.onlinesize = 2,
    required this.profileUrl,
    required this.size,
  }) : super(key: key);

  final bool isOnline;
  final Color onlineColor;
  final double onlinesize;
  final String profileUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(
          width: onlinesize,
          color: onlineColor,
          style: isOnline ? BorderStyle.solid : BorderStyle.none,
        ),
        shape: BoxShape.circle,
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: getColorTheme(context).onPrimary,
        ),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(isOnline ? 5 : 0),
        child: ExtendedImage.network(
          profileUrl,
          fit: BoxFit.cover,
          cache: true,
          clearMemoryCacheWhenDispose: false,
          clearMemoryCacheIfFailed: false,
          loadStateChanged: (ExtendedImageState state) {
            if (state.extendedImageLoadState == LoadState.loading || state.extendedImageLoadState == LoadState.failed) {
              return const Icon(
                Icons.person,
              );
            } else {
              return ExtendedRawImage(
                image: state.extendedImageInfo?.image,
                fit: BoxFit.cover,
              );
            }
          },
        ),
      ),
    );
  }
}
