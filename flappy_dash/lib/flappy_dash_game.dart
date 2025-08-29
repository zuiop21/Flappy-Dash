import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flappy_dash/component/dash.dart';
import 'package:flappy_dash/component/dash_parallax_background.dart';

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
    add(DashParallaxBackground());
    add(Dash());
  }
}
