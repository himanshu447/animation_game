import 'package:animation/components/collsion_bloc.dart';
import 'package:animation/components/player.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'dart:async';

class Level extends World {
  late TiledComponent level;
  final String lavelName;
  final Player player;
  List<CollisionBloc> collisionBlocs = [];

  Level({
    required this.lavelName,
    required this.player,
  });

  @override
  Future<void> onLoad() async {
    level = await TiledComponent.load('$lavelName.tmx', Vector2.all(16));
    add(level);

    final spawnPointPlayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    for (final spawnPoint in spawnPointPlayer!.objects) {
      switch (spawnPoint.class_) {
        case 'Player':
          player.position = Vector2(spawnPoint.x, spawnPoint.y);
          add(player);
          break;
        default:
      }
    }

    add(RectangleHitbox());

    final collisionLayer = level.tileMap.getLayer<ObjectGroup>('Collisions');
    for (final collision in collisionLayer!.objects) {
      switch (collision.class_) {
        case 'Platform':
          final platform = CollisionBloc(
            position: Vector2(collision.x,collision.y),
            size: Vector2(collision.width,collision.height),
            isPlatfrom: true,
          );
          collisionBlocs.add(platform);
          add(platform);
          break;
        default:
          final bloc = CollisionBloc(
            position: Vector2(collision.x,collision.y),
            size: Vector2(collision.width,collision.height),
          );
          collisionBlocs.add(bloc);
          add(bloc);
      }
    }
    player.collisionBlocs = collisionBlocs;
    return super.onLoad();
  }
}
