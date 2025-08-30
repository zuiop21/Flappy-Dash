import 'package:flame/components.dart';
import 'package:flappy_dash/component/pipe.dart';

class PipePair extends PositionComponent {
  static const double gap = 100;
  static const double speed = 100;
  PipePair({required super.position});

  @override
  void onLoad() {
    super.onLoad();
    addAll([
      Pipe(isFlipped: false, position: Vector2(0, gap)),
      Pipe(isFlipped: true, position: Vector2(0, -gap)),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= speed * dt;
  }
}
