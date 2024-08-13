import 'package:client/core/models/song_model.dart';
import 'package:client/core/providers/current_song_provider.dart';
import 'package:client/core/widgets/custom_cached_image.dart';
import 'package:client/core/widgets/music_player.dart';
import 'package:client/features/home/viewmodel/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class SavedFavoriteSongsLibraryWidget extends StatelessWidget {
  final SongModel song;

  const SavedFavoriteSongsLibraryWidget({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10.r,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CustomImage(
          height: 50.h,
          width: 50.w,
          image: song.thumbnailUrl!,
          asDecoration: true,
          borderRadius: BorderRadius.circular(8.r),
        ),
        title: SizedBox(
          width: 100.w,
          child: Text(
            song.songName ?? "",
            style: Theme.of(context).textTheme.displayMedium,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        subtitle: SizedBox(
          width: 100.w,
          child: Text(
            song.artistName ?? "",
            style: Theme.of(context).textTheme.displaySmall,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        trailing: Consumer<CurrentSongProvider>(
            builder: (context, currentSongProvider, child) {
          final homeProvider = context.watch<HomeViewModel>();
          final isCurrentSongPlaying =
              currentSongProvider.currentSong?.id == song.id;
          return SizedBox(
            width: 100.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                IconButton(
                  onPressed: () {
                    if (currentSongProvider.currentSong == song) {
                      currentSongProvider.playPause();
                    } else {
                      context.read<CurrentSongProvider>().updateSong(song);
                    }
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      ),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      isCurrentSongPlaying && currentSongProvider.isPlaying
                          ? CupertinoIcons.pause_fill
                          : CupertinoIcons.play_fill,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
