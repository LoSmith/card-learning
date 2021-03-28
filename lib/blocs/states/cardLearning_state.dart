import 'package:card_learning/domain/models/flashCard.dart';

class CardLearningState {
  final Iterable<FlashCard> flashCards;
  final bool isFetching;
  final bool hasNetworkError;

  CardLearningState({
    this.flashCards,
    this.isFetching: false,
    this.hasNetworkError: false,
  });
}
