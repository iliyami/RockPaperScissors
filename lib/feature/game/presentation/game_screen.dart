import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:scales_ops_task/feature/game/presentation/start_screen.dart';
import 'package:scales_ops_task/feature/game/domain/models/models.dart';
import 'package:scales_ops_task/utils/collision_detector.dart';
import '../../../constants.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<GameObject> objects = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    objects = createObjects(
      random: Random(),
      maxWidth: MediaQuery.sizeOf(context).width,
      maxHeight: MediaQuery.sizeOf(context).height - appBarHeight,
    );
    startGame();
  }

  void startGame() {
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (mounted) {
        setState(() {
          updateDirection();
          CollistionDetector.checkCollisions(objects);
          if (isGameDone()) {
            timer.cancel();
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => const StartScreen()));
          }
        });
      }
    });
  }

  void updateDirection() {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    for (final item in objects) {
      item.x += item.dx;
      item.y += item.dy;
      double xTopLeft = item.x;
      double yTopLeft = item.y;
      double xBottomRight = item.x + squareSize;
      double yBottomRight = item.y + squareSize;

      if (xTopLeft < 0 || xBottomRight > screenWidth) {
        item.dx *= -1;
      }

      if (yTopLeft < 0 || yBottomRight > screenHeight - appBarHeight) {
        item.dy *= -1;
      }
    }
  }

  bool isGameDone() {
    int num = 0;
    for (int i = 0; i < objects.length; i++) {
      for (int j = i + 1; j < objects.length; j++) {
        if (objects[i].type != objects[j].type) {
          num++;
        }
      }
    }

    if (num == 0) return true;
    return false;
  }

  Widget getGameItemWidget(GameObject object) {
    Color color;
    String text;
    IconData iconData;

    switch (object.type) {
      case ItemType.rock:
        color = Colors.green;
        text = 'Rock';
        iconData = Icons.handshake;
        break;
      case ItemType.paper:
        color = Colors.blueAccent;
        text = 'Paper';
        iconData = Icons.back_hand_rounded;
        break;
      case ItemType.scissors:
        color = Colors.orange;
        text = 'Scissors';
        iconData = Icons.content_cut;
        break;
    }

    return Positioned(
      left: object.x,
      top: object.y,
      child: Container(
        width: squareSize,
        height: squareSize,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData),
            Text(text),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.sizeOf(context).width;
    final maxHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Rock Paper Scissors'),
            ElevatedButton(
                onPressed: () => setState(() {
                      objects = createObjects(
                        random: Random(),
                        maxWidth: maxWidth,
                        maxHeight: maxHeight,
                      );
                    }),
                child: const Text("restart"))
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Stack(
          children: [
            for (var object in objects) getGameItemWidget(object),
          ],
        ),
      ),
    );
  }
}

List<GameObject> createObjects({
  required Random random,
  int itemCount = 5,
  required double maxWidth,
  required double maxHeight,
}) {
  return [
    ...generateSpecifiedGameObjects(
        ItemType.paper, itemCount, random, maxWidth, maxHeight),
    ...generateSpecifiedGameObjects(
        ItemType.rock, itemCount, random, maxWidth, maxHeight),
    ...generateSpecifiedGameObjects(
        ItemType.scissors, itemCount, random, maxWidth, maxHeight),
  ];
}

List<GameObject> generateSpecifiedGameObjects(ItemType type, int itemCount,
    Random random, double maxWidth, double maxHeight) {
  List<GameObject> result = [];
  GameObject? newObj;
  for (var i = 0; i < itemCount; i++) {
    do {
      final (x, y) = _getRandomCoor(random, maxWidth, maxHeight);
      newObj = GameObject(
        type: type,
        x: x,
        y: y,
        dx: (random.nextDouble() - 0.5) * 2,
        dy: (random.nextDouble() - 0.5) * 2,
      );
    } while (CollistionDetector.hasCollisionWithTargetObject(result, newObj));
    result.add(newObj);
  }
  return result;
}

(double, double) _getRandomCoor(
    Random random, double screenWidth, double screenHeight) {
  var x = 0.0, y = 0.0;
  do {
    x = (random.nextDouble() % screenWidth) * 444;
    y = (random.nextDouble() % screenHeight) * 444;
  } while (CollistionDetector.isCollidingWithWalls(
      x, y, squareSize, screenWidth, screenHeight));

  return (x, y);
}
