import 'package:scales_ops_task/constants.dart';
import 'package:scales_ops_task/feature/game/domain/models/models.dart';

class CollistionDetector {
  static bool hasCollisionWithTargetObject(
      List<GameObject> objects, GameObject targetObj) {
    for (final obj in objects) {
      if (isColliding(
        targetObj.x,
        targetObj.y,
        obj.x,
        obj.y,
        squareSize,
      )) {
        return true;
      }
    }
    return false;
  }

  static void checkCollisions(List<GameObject> objects) {
    for (int i = 0; i < objects.length; i++) {
      for (int j = i + 1; j < objects.length; j++) {
        if (CollistionDetector.isColliding(
          objects[i].x,
          objects[i].y,
          objects[j].x,
          objects[j].y,
          squareSize,
        )) {
          handleCollision(objects[i], objects[j], objects);
        }
      }
    }
  }

  static void handleCollision(
      GameObject obj1, GameObject obj2, List<GameObject> objects) {
    if (obj1.type == obj2.type) {
      final tempX = obj1.dx;
      final tempY = obj1.dy;
      obj1.dx = obj2.dx;
      obj1.dy = obj2.dy;

      obj2.dx = tempX;
      obj2.dy = tempY;
    } else {
      if ((obj1.type == ItemType.rock && obj2.type == ItemType.scissors) ||
          (obj1.type == ItemType.scissors && obj2.type == ItemType.paper) ||
          (obj1.type == ItemType.paper && obj2.type == ItemType.rock)) {
        objects.remove(obj2);
        obj1.dx *= -1;
        obj1.dy *= -1;
      } else {
        objects.remove(obj1);
        obj2.dx *= -1;
        obj2.dy *= -1;
      }
    }
  }

  static bool isColliding(
      double x1, double y1, double x2, double y2, double size) {
    double squareSize = size;

    double x1TopLeft = x1;
    double y1TopLeft = y1;
    double x1BottomRight = x1 + squareSize;
    double y1BottomRight = y1 + squareSize;

    double x2TopLeft = x2;
    double y2TopLeft = y2;
    double x2BottomRight = x2 + squareSize;
    double y2BottomRight = y2 + squareSize;

    if (x1TopLeft < x2BottomRight &&
        x1BottomRight > x2TopLeft &&
        y1TopLeft < y2BottomRight &&
        y1BottomRight > y2TopLeft) {
      return true;
    }
    return false;
  }

  static bool isCollidingWithWalls(double x, double y, double squareSize,
      double screenWidth, double screenHeight) {
    double xTopLeft = x;
    double yTopLeft = y;
    double xBottomRight = x + squareSize;
    double yBottomRight = y + squareSize;

    if (xTopLeft < 0 ||
        xBottomRight > screenWidth ||
        yTopLeft < 0 ||
        yBottomRight > screenHeight) {
      return true;
    }

    return false;
  }
}
