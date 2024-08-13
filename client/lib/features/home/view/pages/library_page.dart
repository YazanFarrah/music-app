import 'package:client/config/style_constants.dart';
import 'package:client/features/home/view/widgets/saved_favorite_songs_library_widget.dart';
import 'package:client/features/home/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context).favoriteSongs;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: StyleConstants.horizontalPadding.copyWith(),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10.h,
                  );
                },
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: homeViewModel.length,
                itemBuilder: (context, index) {
                  final song = homeViewModel[index];
                  return SavedFavoriteSongsLibraryWidget(
                    song: song,
                    key: ValueKey(
                      song.id,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
