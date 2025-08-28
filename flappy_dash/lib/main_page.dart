import 'package:flame/game.dart';
import 'package:flappy_dash/flappy_dash_game.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final FlappyDashGame game;
  @override
  void initState() {
    super.initState();
    game = FlappyDashGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: game,
        backgroundBuilder: (context) {
          return Container(color: const Color(0xFF87CEEB));
        },
      ),
    );
  }
}
