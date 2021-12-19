class Player {
  final String id;
  final String name;
  int cardsLeft;
  int? starCard;
  int? cardMeter;

  Player({
    required this.id,
    required this.name,
    required this.cardsLeft,
    this.starCard,
    this.cardMeter,
  });
}
