import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';

class FlappyDashGame extends FlameGame<FlappyDashWorld> {
  FlappyDashGame()
    : super(
        world: FlappyDashWorld(),
        camera: CameraComponent.withFixedResolution(width: 720, height: 1280),
      );
}

class FlappyDashWorld extends World {
  @override
  void onLoad() {
    super.onLoad();
    add(Dash());
  }
}

class Dash extends PositionComponent {
  Dash() : super(size: Vector2(20, 20), position: Vector2.zero());

  @override
  void update(double dt) {
    super.update(dt);
    position.x += 100 * dt;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawCircle(Offset.zero, 20, BasicPalette.blue.paint());
  }
}
