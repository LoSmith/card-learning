import 'package:card_learning/models/flashCard.dart';

class FlashCardState {
  final Iterable<FlashCard> cards;
  final bool isFetching;
  final bool hasNetworkError;

  FlashCardState({
    this.cards,
    this.isFetching: false,
    this.hasNetworkError: false,
  });
}
