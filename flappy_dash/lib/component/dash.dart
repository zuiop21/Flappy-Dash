import 'dart:ui';

import 'package:flame/components.dart';

class Dash extends PositionComponent {
  Dash()
    : super(
        size: Vector2.all(80),
        position: Vector2.zero(),
        anchor: Anchor.center,
      );

  late Sprite _dashSprite;

  @override
  Future<void> onLoad() async {
    _dashSprite = await Sprite.load('dash.png');

    await super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position = Vector2.zero();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _dashSprite.render(canvas, size: size);
  }
}
