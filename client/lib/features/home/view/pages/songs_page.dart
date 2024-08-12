import 'package:client/config/style_constants.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/home/view/widgets/latest_today_song_widget.dart';
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
        Padding(
          padding: StyleConstants.horizontalPadding.copyWith(bottom: 20, top: 20),
          child: Text(
            "Latest today:",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        homeProvider.isFetchingSongs
            ? const Loader()
            : SizedBox(
                height: 260.h,
                child: ListView.separated(
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
