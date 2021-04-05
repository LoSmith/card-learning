import 'package:card_learning/models/flashCard.dart';

enum FlashCardsStatus { loading, success, failure, hasNetworkError }

class FlashCardsState {
  const FlashCardsState._({
    this.status = FlashCardsStatus.loading,
    this.items = const <FlashCard>[],
  });

  const FlashCardsState.loading() : this._();

  const FlashCardsState.success(List<FlashCard> items)
      : this._(status: FlashCardsStatus.success, items: items);

  const FlashCardsState.failure() : this._(status: FlashCardsStatus.failure);

  final FlashCardsStatus status;
  final List<FlashCard> items;
}
