import 'package:client/core/models/song_model.dart';
import 'package:client/core/theme/app_colors.dart';
import 'package:client/features/home/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CustomModalSheet extends StatelessWidget {
  final SongModel song;

  const CustomModalSheet({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.read<HomeViewModel>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4,
            margin: const EdgeInsets.only(bottom: 12.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          Text(
            song.songName!,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 4),
          Text(
            song.artistName!,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: Icon(
              homeProvider.isSongSaved(song) == true
                  ? Icons.delete
                  : Icons.save_alt,
              color: SharedColors.grayColor,
            ),
            title: Text(
              homeProvider.isSongSaved(song) == true
                  ? "Delete from saved"
                  : 'Save This Song',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            onTap: () {
              homeProvider.isSongSaved(song) == true
                  ? homeProvider.removeSavedSong(song, context)
                  : homeProvider.saveSongLocally(song, context);
              Navigator.pop(context);
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.playlist_add, color: Colors.green),
          //   title: const Text('Add to Playlist'),
          //   onTap: () {
          //     // Add to playlist functionality
          //     Navigator.pop(context);
          //   },
          // ),
          ListTile(
            leading: const Icon(
              Icons.share,
              color: SharedColors.grayColor,
            ),
            title: Text(
              'Share Song',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            onTap: () {
              // Share song functionality
              Navigator.pop(context);
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.delete, color: Colors.red),
          //   title: const Text('Delete Song'),
          //   onTap: () {
          //     // Delete song functionality
          //     Navigator.pop(context);
          //   },
          // ),
        ],
      ),
    );
  }
}
