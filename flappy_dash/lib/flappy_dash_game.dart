import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_dash/component/dash.dart';
import 'package:flappy_dash/component/dash_parallax_background.dart';
import 'package:flappy_dash/component/pipe_pair.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlappyDashGame extends FlameGame<FlappyDashWorld>
    with KeyboardEvents, HasCollisionDetection {
  FlappyDashGame()
    : super(
        world: FlappyDashWorld(),
        camera: CameraComponent.withFixedResolution(width: 600, height: 800),
      );

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.space) {
        world.onSpaceDown();
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }
}

class FlappyDashWorld extends World
    with TapCallbacks, HasGameReference<FlappyDashGame> {
  late Dash _dash;
  late PipePair _lastPipe;
  static const double _distance = 400;
  int _score = 0;
  late TextComponent _scoreText;

  @override
  void onLoad() {
    super.onLoad();
    add(DashParallaxBackground());

    add(_dash = Dash());
    _generatePipes(fromX: _distance);
    _scoreText = TextComponent(
      text: _score.toString(),
      position: Vector2(0, -(game.size.y / 2)),
    );
    game.camera.viewfinder.add(_scoreText);
  }

  void _generatePipes({int count = 5, double fromX = 0.0}) {
    for (var i = 0; i < count; i++) {
      final area = 600;
      final y = (Random().nextDouble() * area) - (area / 2);
      add(_lastPipe = PipePair(position: Vector2(fromX + (i * _distance), y)));
    }
  }

  void incrementScore() {
    _score += 1;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _scoreText.text = _score.toString();
    if (_dash.x >= _lastPipe.x) {
      _generatePipes(fromX: _distance);
      _removePipes();
    }
    // game.camera.viewfinder.zoom = 0.1;
  }

  void _removePipes() {
    final pipes = children.whereType<PipePair>();
    final shouldBeRemoved = max(pipes.length - 5, 0);
    pipes.take(shouldBeRemoved).forEach((pipe) {
      pipe.removeFromParent();
    });
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    _dash.jump();
  }

  void onSpaceDown() {
    _dash.jump();
  }
}
