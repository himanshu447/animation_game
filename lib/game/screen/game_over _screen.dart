import 'package:animation/game/assets.dart';
import 'package:animation/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final FlappyBirdGame flappyBirdGame;

  const GameOverScreen({
    Key? key,
    required this.flappyBirdGame,
  }) : super(key: key);

  static const String id = 'GameOver';

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.gameOver,
            ),
            RawMaterialButton(
              onPressed: (){
                flappyBirdGame.overlays.remove(GameOverScreen.id);
                flappyBirdGame.bird.reset();
              },
              fillColor: Colors.orange,
              child: const Text(
                'Reset',
              ),
            )
          ],
        ),
      ),
    );
  }
}
