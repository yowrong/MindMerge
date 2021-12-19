class Player {
  final String name;
  int cardsLeft;
  int? starCard;
  double? cardMeter;

  Player({
    required this.name,
    required this.cardsLeft,
    this.starCard,
    this.cardMeter,
  });
}
