// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';

// class ThemeProvider with ChangeNotifier {
//   static ThemeMode themeMode = ThemeMode.light;

//   bool get isDarkMode {
//     //get from the box
//     final bool? isDarkMode = Hive.box(AppSettingsBoxConstants.boxName).get(
//       AppSettingsBoxConstants.isDarkMode,
//     );
//     if (isDarkMode != null) {
//       themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
//       return isDarkMode;
//     }
//     return SchedulerBinding.instance.platformDispatcher.platformBrightness ==
//         Brightness.dark;
//   }

//   Future<void> toggleThemeToDark(bool isOn) async {
//     themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
//     notifyListeners();
//     await Hive.box(AppSettingsBoxConstants.boxName).put(
//       AppSettingsBoxConstants.isDarkMode,
//       isOn,
//     );
//   }

//   Future<void> setDefaultFromSystem(BuildContext context) async {
//     if (View.of(context).platformDispatcher.platformBrightness ==
//         Brightness.dark) {
//       await toggleThemeToDark(true);
//     } else {
//       await toggleThemeToDark(false);
//     }
//   }
// }
