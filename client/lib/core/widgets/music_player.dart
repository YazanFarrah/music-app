import 'dart:math';

import 'package:client/config/asset_paths.dart';
import 'package:client/config/style_constants.dart';
import 'package:client/core/models/song_model.dart';
import 'package:client/core/providers/current_song_provider.dart';
import 'package:client/core/utils/color_utils.dart';
import 'package:client/core/widgets/custom_cached_image.dart';
import 'package:client/core/widgets/song_info_modal_sheet.dart';
import 'package:client/features/home/viewmodel/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class MusicPlayer extends StatelessWidget {
  final SongModel song;
  const MusicPlayer({
    super.key,
    required this.song,
  });

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeViewModel>();
    return Container(
      padding: StyleConstants.horizontalPadding.copyWith(top: 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            hexToColor(
              song.hexCode ?? generateRandomHexColor(),
            ),
            const Color(0XFF121212),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Transform.translate(
            offset: const Offset(-15, 0),
            child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                context.pop();
              },
              icon: Transform.rotate(
                angle: pi / 2,
                child: const Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0)),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  context: context,
                  builder: (context) {
                    return CustomModalSheet(
                      song: song,
                    );
                  },
                );
              },
              icon: const Icon(
                CupertinoIcons.ellipsis,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30.w),
                child: CustomImage(
                  fit: BoxFit.cover,
                  image: song.thumbnailUrl!,
                  asDecoration: true,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            song.songName!,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            song.songName!,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                      const Spacer(),
                      LikeButton(
                        isLiked: homeProvider.isSongFav(song),
                        onTap: (isLiked) {
                          return homeProvider.favUnfavSong(
                            context: context,
                            song: song,
                          );
                        },
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            isLiked
                                ? CupertinoIcons.heart_fill
                                : CupertinoIcons.heart,
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Consumer<CurrentSongProvider>(
                      builder: (context, currentSongProvider, child) {
                    currentSongProvider.currentSong?.id == song.id;
                    return StreamBuilder(
                        stream: currentSongProvider.audioPlayer!.positionStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox.shrink();
                          }

                          final position = snapshot.data;
                          final duration =
                              currentSongProvider.audioPlayer!.duration;
                          double sliderValue = 0.0;
                          if (position != null && duration != null) {
                            sliderValue = position.inMilliseconds /
                                duration.inMilliseconds;
                          }
                          return Column(
                            children: [
                              StatefulBuilder(
                                builder: (context, setState) {
                                  return SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      activeTrackColor: Colors.white,
                                      inactiveTrackColor:
                                          Colors.white.withOpacity(0.117),
                                      thumbColor: Colors.white,
                                      trackHeight: 4,
                                      overlayShape:
                                          SliderComponentShape.noOverlay,
                                    ),
                                    child: Slider(
                                      value: sliderValue,
                                      min: 0,
                                      max: 1,
                                      onChangeStart: (value) {
                                        if (currentSongProvider.isPlaying) {
                                          currentSongProvider.playPause();
                                        }
                                      },
                                      onChanged: (value) {
                                        sliderValue = value;
                                        setState(() {});
                                      },
                                      onChangeEnd: (value) {
                                        currentSongProvider.seek(value);
                                        currentSongProvider.playPause();
                                      },
                                    ),
                                  );
                                },
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${position?.inMinutes}:${(position?.inSeconds ?? 0) % 60 < 10 ? '0${(position?.inSeconds ?? 0) % 60}' : (position?.inSeconds ?? 0) % 60}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                  const Spacer(),
                                  Text(
                                    "${duration?.inMinutes}:${(duration?.inSeconds ?? 0) % 60 < 10 ? '0${(duration?.inSeconds ?? 0) % 60}' : (duration?.inSeconds ?? 0) % 60}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                ],
                              ),
                            ],
                          );
                        });
                  }),
                  SizedBox(height: 15.h),
                  Consumer<CurrentSongProvider>(
                      builder: (context, currentSongProvider, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.r),
                          child: Image.asset(AssetPaths.shuffle),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.r),
                          child: Image.asset(AssetPaths.previousSong),
                        ),
                        IconButton(
                          onPressed: () {
                            currentSongProvider.playPause();
                          },
                          icon: Icon(
                            currentSongProvider.isPlaying
                                ? CupertinoIcons.pause_circle_fill
                                : CupertinoIcons.play_circle_fill,
                            size: 80.r,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.r),
                          child: Image.asset(AssetPaths.nextSong),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.r),
                          child: Image.asset(AssetPaths.repeat),
                        ),
                      ],
                    );
                  }),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.r),
                        child: Image.asset(AssetPaths.connectDevice),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.all(10.r),
                        child: Image.asset(AssetPaths.playlist),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
