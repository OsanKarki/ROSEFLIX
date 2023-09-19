import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

import 'core/routes/app_routes.dart';
import 'feature/home/presentation/pages/home_screen.dart';
import 'injection.dart';

void main() async {
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MovieApp(savedThemeMode: savedThemeMode));
}

class MovieApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  final _appRouter = AppRouter();

  MovieApp({
    Key? key,
    this.savedThemeMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
          drawerTheme: DrawerThemeData(
            shadowColor: Colors.white
          ),
          primarySwatch: Colors.red,
          brightness: Brightness.light,
          hintColor: Colors.black,
          appBarTheme: AppBarTheme(backgroundColor: Colors.white)),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
        hintColor: Colors.grey,
        backgroundColor: Colors.black,
        appBarTheme: AppBarTheme(backgroundColor: Colors.black),
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (darkTheme, theme) => GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: _appRouter.config(),
          theme: theme,
          darkTheme: ThemeData.dark(),
        ),
      ),
    );
  }
}
