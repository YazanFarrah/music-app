import 'package:client/core/providers/current_song_provider.dart';
import 'package:client/core/utils/color_utils.dart';
import 'package:client/core/widgets/music_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class MusicSlap extends StatelessWidget {
  const MusicSlap({super.key});

  @override
  Widget build(BuildContext context) {
    final currentSong = Provider.of<CurrentSongProvider>(context).currentSong;
    final currentSongProvider = context.read<CurrentSongProvider>();

    if (currentSong == null) {
      return const SizedBox.shrink();
    } else {
      return GestureDetector(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return MusicPlayer(
                song: currentSong,
              );
            },
          );
        },
        child: Stack(
          children: [
            Container(
              height: 66.h,
              decoration: BoxDecoration(
                color: hexToColor(
                  currentSong.hexCode ?? generateRandomHexColor(),
                ),
                borderRadius: BorderRadius.circular(
                  8.r,
                ),
              ),
              padding: EdgeInsets.all(9.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Hero(
                        tag: "music-image",
                        child: Container(
                          width: 48.w,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                currentSong.thumbnailUrl!,
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentSong.songName!,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  color: getColorBasedOnBackground(
                                    currentSong.hexCode ??
                                        generateRandomHexColor(),
                                  ),
                                ),
                          ),
                          Text(
                            currentSong.artistName!,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  color: getColorBasedOnBackground(
                                    currentSong.hexCode ??
                                        generateRandomHexColor(),
                                  ),
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: LikeButton(
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              isLiked
                                  ? CupertinoIcons.heart_fill
                                  : CupertinoIcons.heart,
                              color: getColorBasedOnBackground(
                                currentSong.hexCode ?? generateRandomHexColor(),
                              ),
                            );
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          currentSongProvider.playPause();
                        },
                        icon: Icon(
                          currentSongProvider.isPlaying
                              ? CupertinoIcons.pause_fill
                              : CupertinoIcons.play_fill,
                          color: getColorBasedOnBackground(
                            currentSong.hexCode ?? generateRandomHexColor(),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: context.locale == const Locale("en") ? 8 : null,
              right: context.locale == const Locale("ar") ? 8 : null,
              child: Container(
                height: 2.3,
                width: MediaQuery.of(context).size.width - 32.w,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
              ),
            ),
            StreamBuilder(
                stream: currentSongProvider.audioPlayer!.positionStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox.shrink();
                  }
                  final position = snapshot.data;
                  final duration = currentSongProvider.audioPlayer!.duration;
                  double sliderValue = 0.0;
                  if (position != null && duration != null) {
                    sliderValue =
                        position.inMilliseconds / duration.inMilliseconds;
                  }
                  return Positioned(
                    bottom: 0,
                    left: context.locale == const Locale("en") ? 8 : null,
                    right: context.locale == const Locale("ar") ? 8 : null,
                    child: Container(
                      height: 2.3,
                      width: sliderValue *
                          (MediaQuery.of(context).size.width - 32),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                  );
                }),
          ],
        ),
      ).animate().flipV();
    }
  }
}
