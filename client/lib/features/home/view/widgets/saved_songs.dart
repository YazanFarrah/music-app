import 'package:client/core/models/song_model.dart';
import 'package:client/core/providers/current_song_provider.dart';
import 'package:client/core/utils/color_utils.dart';
import 'package:client/core/widgets/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SavedSongsWidget extends StatelessWidget {
  final SongModel song;
  const SavedSongsWidget({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<CurrentSongProvider>().updateSong(song);
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: hexToColor(
            song.hexCode ?? generateRandomHexColor(),
          ),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          children: [
            CustomImage(
              image: song.thumbnailUrl!,
              width: 56.w,
              asDecoration: true,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(4.r),
                topLeft: Radius.circular(4.r),
              ),
            ),
            SizedBox(width: 8.w),
            Flexible(
              child: Text(
                song.songName ?? "",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 13.sp,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
