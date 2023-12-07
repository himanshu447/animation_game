import 'package:animation/game/assets.dart';
import 'package:animation/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';

class MainMenuScreen extends StatelessWidget {
  final FlappyBirdGame flappyBirdGame;
  static const String id = 'MainMenu';

  const MainMenuScreen({
    Key? key,
    required this.flappyBirdGame,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    flappyBirdGame.pauseEngine();
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          flappyBirdGame.overlays.remove('MainMenu');
          flappyBirdGame.resumeEngine();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.menu),
              fit: BoxFit.cover,
            ),
          ),
          child: Image.asset(
            Assets.message
          ),
        ),
      ),
    );
  }
}
