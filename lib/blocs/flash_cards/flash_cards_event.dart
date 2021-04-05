import 'package:card_learning/models/flashCard.dart';

abstract class FlashCardEvent {}

class FlashCardEventCreate extends FlashCardEvent {
  final String solution;
  final String question;
  final String id;

  FlashCardEventCreate(this.id, this.question, this.solution);
}

class CardEventCreatCardList extends FlashCardEvent {
  final List<FlashCard> cards;

  CardEventCreatCardList(this.cards);
}

class CardEventDeleteCard extends FlashCardEvent {
  final String id;

  CardEventDeleteCard(this.id);
}
