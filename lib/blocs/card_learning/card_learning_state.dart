import 'package:card_learning/models/flash_card.dart';

enum CardLearningStatus { loading, success, failure }

class CardLearningState {
  const CardLearningState._({
    this.status = CardLearningStatus.loading,
    this.items = const <FlashCard>[],
  });

  const CardLearningState.loading() : this._();

  const CardLearningState.success(List<FlashCard> items)
      : this._(status: CardLearningStatus.success, items: items);

  const CardLearningState.failure() : this._(status: CardLearningStatus.failure);

  final CardLearningStatus status;
  final List<FlashCard> items;
}
