import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/config/asset_paths.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final bool isNotification;
  final String placeholder;
  final bool? noPlaceHolder;
  final bool? noErrorHandler;
  final bool? largePlaceErrorScale;
  
  final bool asDecoration; //New parameter to toggle DecorationImage usage

  // Decoration properties
  final BorderRadiusGeometry? borderRadius;
  final BoxShadow? boxShadow;
  final Gradient? gradient;
  final Color? backgroundColor;
  const CustomImage({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.isNotification = false,
    this.placeholder = '',
    this.noPlaceHolder,
    this.noErrorHandler,
    this.largePlaceErrorScale,
    this.asDecoration = false,
    this.borderRadius,
    this.boxShadow,
    this.gradient,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) {
        if (asDecoration) {
          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              boxShadow: boxShadow != null ? [boxShadow!] : null,
              gradient: gradient,
              color: backgroundColor,
              image: DecorationImage(
                image: imageProvider,
                fit: fit,
              ),
            ),
          );
        } else {
          return Image(
            image: imageProvider,
            height: height,
            width: width,
            fit: fit,
          );
        }
      },
      placeholder: (context, url) {
        return noPlaceHolder == true
            ? const SizedBox.shrink()
            : Center(
                child: Image.asset(
                  AssetPaths.appLogo,
                  fit: largePlaceErrorScale == true
                      ? BoxFit.contain
                      : BoxFit.scaleDown,
                  height: height,
                  width: width,
                ),
              );
      },
      errorWidget: (context, url, error) {
        return noErrorHandler == true
            ? const SizedBox.shrink()
            : const Center(
                child: Icon(
                  Icons.error,
                ),
              );
      },
    );
  }
}
