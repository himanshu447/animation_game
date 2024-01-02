import 'package:animation/components/collsion_bloc.dart';
import 'package:animation/components/player.dart';

bool checkCollision(Player player, CollisionBloc block) {
  final playerX = player.position.x;
  final playerY = player.position.y;
  final playerWidth = player.width;
  final playerHeight = player.height;

  final blocX = block.x;
  final blocY = block.y;
  final blocWidth = block.width;
  final blocHeight = block.height;

  return (
      playerY < blocY + blocHeight &&
      playerY + playerHeight > blocY &&
      playerX < blocX + blocHeight
  );

  return true;
}
