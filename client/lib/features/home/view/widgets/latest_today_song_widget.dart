import 'package:client/core/models/song_model.dart';
import 'package:client/core/providers/current_song_provider.dart';
import 'package:client/core/widgets/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LatestSongWidget extends StatelessWidget {
  final SongModel song;
  const LatestSongWidget({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<CurrentSongProvider>().updateSong(song);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImage(
            image: song.thumbnailUrl!,
            width: 180.w,
            height: 180.w,
            fit: BoxFit.cover,
            asDecoration: true,
            borderRadius: BorderRadius.circular(7.r),
          ),
          SizedBox(
            height: 6.h,
          ),
          SizedBox(
            width: 180.w,
            child: Text(
              song.songName ?? "",
              style: Theme.of(context).textTheme.displayMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          SizedBox(
            width: 180.w,
            child: Text(
              song.artistName ?? "",
              style: Theme.of(context).textTheme.displaySmall,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
