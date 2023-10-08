enum ItemType {
  rock,
  paper,
  scissors,
}

class GameObject {
  final ItemType type;
  double x;
  double y;
  double dx;
  double dy;

  GameObject({
    required this.type,
    required this.x,
    required this.y,
    required this.dx,
    required this.dy,
  });
}
