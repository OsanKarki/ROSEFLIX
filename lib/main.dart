import 'package:flutter/material.dart';

import 'core/routes/app_routes.dart';
import 'feature/home/presentation/pages/home_screen.dart';
import 'injection.dart';

void main() {
  configureDependencies();
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  MovieApp({Key? key}) : super(key: key);
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _appRouter.config(),
        theme: ThemeData.dark(),
      ),
    );
  }
}
