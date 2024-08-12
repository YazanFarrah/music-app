import 'dart:developer';
import 'package:client/core/providers/bottom_nav_bar_provider.dart';
import 'package:client/core/providers/current_song_provider.dart';
import 'package:client/core/providers/current_user_provider.dart';
import 'package:client/core/router/router.dart';
import 'package:client/core/theme/app_themes.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:client/features/home/viewmodel/home_view_model.dart';
import 'package:client/features/home/viewmodel/upload_song_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        Future.delayed(
          Duration.zero,
          () async {
            log("inactive app ");
          },
        );
        break;
      case AppLifecycleState.resumed:
        Future.delayed(
          Duration.zero,
          () {
            log("resume app");
          },
        );
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) async {});
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  Future<void> dispose() async {
    Future.delayed(
      Duration.zero,
      () async {},
    );
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),
        ChangeNotifierProvider<CurrentUserProvider>(
          create: (_) => GetIt.I<CurrentUserProvider>(),
        ),
        ChangeNotifierProvider(create: (context) => UploadSongViewModel()),
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ChangeNotifierProvider(create: (context) => CurrentSongProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(384.0, 808.17),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          // navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: '',
          themeMode: ThemeMode.dark,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          routerConfig: appRouter.router,
        ),
      ),
    );
  }
}
