import 'dart:ui';

import 'package:flame/components.dart';

class Dash extends PositionComponent {
  Dash()
    : super(
        size: Vector2.all(80),
        position: Vector2.zero(),
        anchor: Anchor.center,
        priority: 10,
      );

  late Sprite _dashSprite;
  Vector2 _velocity = Vector2.zero();
  final Vector2 _gravity = Vector2(0, 1400);
  final Vector2 _jumpForce = Vector2(0, -500);

  @override
  Future<void> onLoad() async {
    _dashSprite = await Sprite.load('dash.png');

    await super.onLoad();
  }

  void jump() {
    _velocity = _jumpForce;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _velocity += _gravity * dt;
    position += _velocity * dt;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _dashSprite.render(canvas, size: size);
  }
}
