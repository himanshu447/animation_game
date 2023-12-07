
import 'dart:ui';

import 'package:animation/game/components/background.dart';
import 'package:animation/game/components/bird.dart';
import 'package:animation/game/components/ground.dart';
import 'package:animation/game/components/pipe.dart';
import 'package:animation/game/config.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/text.dart';

import 'components/pipe_group.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {

  Timer interval = Timer(Config.pipeInterval,repeat: true);
  late Bird bird;
  bool isHit = false;
  late TextComponent score;

  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
      Ground(),
      bird = Bird(),
      score = buildScrore(),
    ]);
    interval.onTick = ()=> add(PipeGroup());
  }

  @override
  void onTap() {
    super.onTap();
    bird.fly();
  }

  buildScrore(){
   return TextComponent(
      text: 'Score ',
     anchor: Anchor.center,
     position: Vector2(size.x / 2, size.y / 2 * 0.2),
     textRenderer: TextPaint(
       style: const TextStyle(
         fontWeight: FontWeight.bold,
         fontSize: 40
       )
     )
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);

    score.text = 'Score ${bird.score}';
  }
}