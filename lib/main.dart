import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sudoku_starter/game.dart';
import 'package:sudoku_starter/home.dart';

import 'end.dart';

void main() {
  runApp(const MyApp());
}

const String gameName = "Flutter Sudoku";

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Home(title: gameName),
    ),
    GoRoute(
        path: '/game',
        builder: (context, state) => const Game(title: gameName)),
    GoRoute(path: '/end', builder: (context, state) => const End()),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
