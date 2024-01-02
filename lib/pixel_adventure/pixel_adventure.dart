import 'package:animation/components/player.dart';
import 'package:animation/components/lavel.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';

class PixelAdventure extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks , HasCollisionDetection {
  @override
  Color backgroundColor() => const Color(0xFF211F30);

  late final CameraComponent cam;
  Player player = Player(character: 'Mask Dude');
  late JoystickComponent joystickComponent;

  @override
  Future<void> onLoad() async {
    ///Load all images into cache
    await images.loadAllImages();

    final world = Level(lavelName: 'Level-01', player: player);
    cam = CameraComponent.withFixedResolution(
      width: 640,
      height: 360,
      world: world,
    );
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([
      cam,
      world,
    ]);

    addJoyStick();

    return super.onLoad();
  }

  void addJoyStick() {
    joystickComponent = JoystickComponent(
      knobRadius: 66,
      margin: const EdgeInsets.only(left: 34,bottom: 10),
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Joystick.png')
        )
      ),
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Knob.png'),
        ),
      ),
    );
    add(joystickComponent);
  }
  @override
  void update(double dt) {
    updateJoystick();
    super.update(dt);
  }

  updateJoystick(){
    switch(joystickComponent.direction){
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.horizontalMovement = 1;
        break;
      default:
        player.horizontalMovement = 0;
        break;
    }
  }

}
