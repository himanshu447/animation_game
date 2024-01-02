import 'package:flame/components.dart';

class CollisionBloc extends PositionComponent {
  bool isPlatfrom;

  CollisionBloc({
    position,
    size,
    this.isPlatfrom = false,
  }) : super(position: position, size: size){
    debugMode = true;
  }
}
