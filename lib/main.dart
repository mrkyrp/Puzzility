import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puzzility/ThemeProvider.dart';
import 'package:puzzility/service/PlayerRepository.dart';
import 'package:puzzility/service/PuzzleRepository.dart';
import 'package:puzzility/views/splash/SplashView.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PuzzleRepository()),
          ChangeNotifierProvider(create: (_) => PlayerRepository()),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashView(),
      theme: ThemeProvider().theme(),
    );
    //  return ChangeNotifierProvider(
    //   create: (context) => PuzzleRepository(),
    //   child: MaterialApp(
    //     home: SplashView(),
    //     theme: ThemeProvider().theme(),
    //   ),
    // );
  }
}
