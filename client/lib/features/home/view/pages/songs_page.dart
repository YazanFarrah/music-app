import 'package:client/config/style_constants.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/home/view/widgets/latest_today_song_widget.dart';
import 'package:client/features/home/view/widgets/saved_songs.dart';
import 'package:client/features/home/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SongsPage extends StatelessWidget {
  const SongsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        homeProvider.getSavedSongs().isEmpty
            ? const SizedBox.shrink()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            StyleConstants.horizontalPadding.copyWith(top: 20),
                        child: Text(
                          "Saved Songs:",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: StyleConstants.horizontalPadding
                              .copyWith(top: 20),
                          child: Text(
                            "View all",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      bottom: 36.h,
                    ),
                    child: Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: homeProvider.savedSongs.length > 4
                              ? 4
                              : homeProvider.savedSongs.length,
                          itemBuilder: (context, index) {
                            final song = homeProvider.savedSongs[index];
                            return SavedSongsWidget(song: song);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
        Padding(
          padding:
              StyleConstants.horizontalPadding.copyWith(bottom: 20, top: 20),
          child: Text(
            "Latest today:",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        homeProvider.isFetchingSongs
            ? const Loader()
            : SizedBox(
                height: 260.h,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: StyleConstants.horizontalPadding,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return LatestSongWidget(
                      song: homeProvider.songs[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 20.w);
                  },
                  itemCount: homeProvider.songs.length,
                ),
              ),
      ],
    );
  }
}
