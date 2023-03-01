import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:brain_application/screens/game/attention/LevelGame/Level1/base/game_component.dart';
import 'package:brain_application/screens/game/attention/LevelGame/Level1/game/game_controller.dart';

enum MapTileBuildStatus { Empty, BuildPreview, BuildDone }

enum MapTileBuildEvent { None, BuildPreview, BuildDone, BuildCancel }

class MapTileComponent extends GameComponent with Tappable {
  MapTileBuildStatus buildStatus = MapTileBuildStatus.Empty;
  GameComponent? refComponent;
  bool ableToBuild = true;
  Sprite? background;

  MapTileComponent({
    Vector2? position,
    Vector2? size,
  }) : super(
          position: position,
          size: size,
        );

  void render(Canvas c) {
    super.render(c);

    double centerX = 10 / 2;
    double centerY = 10 / 2;
    double radius = 20;
    double startAngle = 0;
    double sweepAngle = pi;

    Path path = Path();
    path.moveTo(radius * cos(startAngle),  radius * sin(startAngle));
    path.arcToPoint(
      Offset(radius * cos(startAngle + sweepAngle), radius * sin(startAngle + sweepAngle)),
      radius: Radius.circular(radius),
      clockwise: false,
    );

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      // ..strokeWidth = 5.0
      ..color = Colors.blue.shade100;

    c.drawPath(path, paint);
  }
  // void render(Canvas canvas) {
  //   Paint paint = Paint()
  //     ..color = Colors.blue
  //     ..strokeWidth = 5.0
  //     ..style = PaintingStyle.stroke;
  //
  //   double centerX = 10 / 2;
  //   double centerY = 10 / 2;
  //
  //   Rect rect = Rect.fromCircle(center: Offset(centerX, centerY), radius: 100);
  //
  //   double startAngle = -math.pi / 2;
  //   double sweepAngle = math.pi;
  //
  //   canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  // }


  @override
  bool onTapDown(TapDownInfo event) {
    gameRef.gameController.send(this, GameControl.WEAPON_BUILDING);
    return false;
  }
}
