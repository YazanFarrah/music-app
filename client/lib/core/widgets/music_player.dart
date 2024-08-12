import 'package:client/core/models/song_model.dart';
import 'package:client/core/widgets/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MusicPlayer extends StatelessWidget {
  final SongModel song;
  const MusicPlayer({
    super.key,
    required this.song,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: CustomImage(
              fit: BoxFit.cover,
              image: song.thumbnailUrl!,
              asDecoration: true,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ],
      ),
    );
  }
}
