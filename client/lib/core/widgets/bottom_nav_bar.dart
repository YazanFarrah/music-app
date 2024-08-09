import 'package:client/core/providers/bottom_nav_bar_provider.dart';
import 'package:client/features/home/view/home_screen.dart';
import 'package:client/features/home/view/upload_song_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  final List<Widget> _screens = const [
    HomeScreen(),
    UploadSongScreen(),
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
              child: _screens[provider.currentIndex],
            ),
            bottomNavigationBar: BottomNavigationBar(
              // selectedItemColor: Theme.of(context).colorScheme.primary,
              // unselectedItemColor: Theme.of(context).colorScheme.onBackground,
              // backgroundColor: Theme.of(context).colorScheme.background,
              currentIndex: provider.currentIndex,
              onTap: (index) {
                provider.setIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'Upload song',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
