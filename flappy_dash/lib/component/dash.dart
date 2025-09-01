import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_dash/component/hidden_coin.dart';
import 'package:flappy_dash/component/pipe.dart';
import 'package:flappy_dash/flappy_dash_game.dart';

class Dash extends PositionComponent
    with CollisionCallbacks, HasGameReference<FlappyDashGame> {
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
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is HiddenCoin) {
      game.world.incrementScore();
      other.removeFromParent();
    } else if (other is Pipe) {
      removeFromParent();
    }
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _dashSprite = await Sprite.load('dash.png');
    final radius = size.x / 2;
    add(
      CircleHitbox(
        radius: radius * 0.8,
        anchor: Anchor.center,
        position: size / 2,
      ),
    );
    debugMode = true;
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
