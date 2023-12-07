import 'package:animation/game/config.dart';
import 'package:animation/game/flappy_bird_game.dart';
import 'package:animation/game/screen/game_over%20_screen.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';

import '../assets.dart';

class Bird extends SpriteGroupComponent<BirdMovement> with HasGameRef<FlappyBirdGame> , CollisionCallbacks {

  int score = 0;

  fly(){
    add(MoveByEffect(
        Vector2(0,Config.gravity),
        EffectController(duration: 0.2,curve: Curves.decelerate),
        onComplete: () => current = BirdMovement.down,
    ),
    );
    current = BirdMovement.up;
  }

  @override
  Future<void> onLoad() async {
    final birdMidFlap = await gameRef.loadSprite(Assets.birdMidFlap);
    final birdUpFlap = await gameRef.loadSprite(Assets.birdUpFlap);
    final birdDownFlap = await gameRef.loadSprite(Assets.birdDownFlap);

    size = Vector2(50,40);
    position = Vector2(50, gameRef.size.y / 2 - size.y);
    current = BirdMovement.middle;

    sprites = {
      BirdMovement.down : birdDownFlap,
      BirdMovement.up: birdUpFlap,
      BirdMovement.middle : birdMidFlap,
    };

    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += Config.birdVelocity * dt;
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    gameOver();
  }

  gameOver(){
    game.overlays.add(GameOverScreen.id);
    gameRef.pauseEngine();
    gameRef.isHit = true;
  }

  reset(){
    position = Vector2(50, gameRef.size.y / 2 - size.y);
    gameRef.bird.score = 0;
    gameRef.resumeEngine();
  }
}