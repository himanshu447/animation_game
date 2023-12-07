import 'dart:math';

import 'package:animation/game/components/pipe.dart';
import 'package:animation/game/config.dart';
import 'package:animation/game/flappy_bird_game.dart';
import 'package:flame/components.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame>{

  final Random _random = Random();

  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;

    final heightMinusGround = gameRef.size.y - Config.groundHeight;
    final space = 100 + _random.nextDouble() * (heightMinusGround / 4);
    final centery = space + _random.nextDouble() * (heightMinusGround - space);

    addAll([
      Pipe(pipePosition: PipePosition.top, height: centery - space / 2),
      Pipe(pipePosition: PipePosition.bottom, height: heightMinusGround - (centery + space / 2 )),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= Config.gameSpeed * dt;

    if(position.x < -20){
      removeFromParent();
      updateScore();
    }

    if(gameRef.isHit){
      removeFromParent();
      gameRef.isHit = false;
    }
  }

  updateScore(){
    gameRef.bird.score += 1;
  }


}
