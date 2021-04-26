import 'package:card_learning/models/flash_card.dart';

enum FlashCardRepositoryStatus { loading, success, failure }

class CardListState {
  const CardListState._({
    this.status = FlashCardRepositoryStatus.loading,
    this.items = const <FlashCard>[],
  });

  const CardListState.loading() : this._();

  const CardListState.success(List<FlashCard> items)
      : this._(status: FlashCardRepositoryStatus.success, items: items);

  const CardListState.failure() : this._(status: FlashCardRepositoryStatus.failure);

  final FlashCardRepositoryStatus status;
  final List<FlashCard> items;
}
