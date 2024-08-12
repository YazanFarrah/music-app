import 'package:client/config/asset_paths.dart';
import 'package:client/core/providers/bottom_nav_bar_provider.dart';
import 'package:client/core/theme/app_colors.dart';
import 'package:client/core/widgets/music_slap.dart';
import 'package:client/features/home/view/pages/home_page.dart';
import 'package:client/features/home/view/pages/upload_song_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  final List<Widget> _screens = const [
    HomePage(),
    UploadSongPage(),
    Text("3rd"),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BottomNavProvider(),
      child: Consumer<BottomNavProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  _screens[provider.currentIndex],
                  const Positioned(
                    bottom: 0,
                    right: 8,
                    left: 8,
                    child: MusicSlap(),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: provider.currentIndex,
              onTap: (index) {
                provider.setIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    provider.currentIndex == 0
                        ? AssetPaths.homeIconFilled
                        : AssetPaths.homeIconUnFilled,
                    color: provider.currentIndex == 0
                        ? Colors.white
                        : SharedColors.greyTextColor,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    AssetPaths.libraryIconFilled,
                    color: provider.currentIndex == 1
                        ? Colors.white
                        : SharedColors.greyTextColor,
                  ),
                  label: 'Library',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    provider.currentIndex == 2
                        ? AssetPaths.searchIconFilled
                        : AssetPaths.searchIconUnFilled,
                    color: provider.currentIndex == 2
                        ? Colors.white
                        : SharedColors.greyTextColor,
                  ),
                  label: 'Search',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
