import 'package:client/core/providers/current_song_provider.dart';
import 'package:client/core/utils/color_utils.dart';
import 'package:client/features/home/view/pages/songs_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<CurrentSongProvider>(
            builder: (context, currentSong, child) {
          final song = currentSong.currentSong;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: song == null
                ? null
                : BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        hexToColor(
                          song.hexCode ?? generateRandomHexColor(),
                        ),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.3],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
            child: const Column(
              children: [
                SizedBox(height: 25),
                SongsPage(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
