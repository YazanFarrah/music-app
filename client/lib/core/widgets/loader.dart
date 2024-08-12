import 'package:client/config/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: Colors.white,
      ),
    );
  }
}

class UploadLoaderAnimation extends StatelessWidget {
  const UploadLoaderAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          AssetPaths.uploadSongAnimation,
        ),
      ),
    );
  }
}
