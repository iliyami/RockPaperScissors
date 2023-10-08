# scales_ops_task

Creating a Rock, Paper, Scissors Game in Flutter

### Overview

This Flutter application is designed to simulate a game of "Rock, Paper, Scissors." In this game, you will have 5 rocks, 5 papers, and 5 scissors represented as square containers on the screen. These objects will be randomly positioned on the screen and will start moving in random directions. The game follows the following rules:

1. Objects will bounce off the screen boundaries if they hit the walls.
2. When two objects collide, the outcome depends on their type:
   - If two objects are of the same type (e.g., two rocks), they will bounce off each other.
   - If two objects are not of the same type (e.g., a rock and a scissor), one of them will be removed from the screen, and the winner will bounce while changing its direction.

### Getting Started

To run this Flutter game on your device, follow these steps:

1. Clone the repository to your local machine:

   ```shell
   git clone https://github.com/iliyami/RockPaperScissors
   ```

2. Navigate to the project directory:

   ```shell
   cd RockPaperScissors
   ```

3. Install the required dependencies:

   ```shell
   flutter pub get
   ```

4. Connect your device/emulator to your computer and ensure it's detected by Flutter.

5. Run the game on your device:

   ```shell
   flutter run
   ```

### Gameplay

- Upon running the game, you will see 5 rocks, 5 papers, and 5 scissors randomly distributed on the screen.
- Each object will start moving in a random direction.
- Objects will bounce off the screen boundaries if they collide with the walls.
- When two objects collide, the game will determine the outcome based on the object types (rock, paper, or scissors) as described in the rules above.
- The game will continue until all objects of one type remain, signifying a win for that object type.



Enjoy the game of Rock, Paper, Scissors in the digital world! Have fun, experiment, and feel free to contribute to or modify this project as you see fit.
