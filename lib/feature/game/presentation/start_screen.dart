import 'package:flutter/material.dart';
import 'package:scales_ops_task/feature/game/presentation/game_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => const GameScreen(),
                  ),
                );
              },
              child: const Text("Start"),
            )
          ],
        ),
      ),
    );
  }
}
