import 'package:card_learning/models/flash_card.dart';

enum FlashCardRepositoryStatus { loading, success, failure, hasNetworkError }

class FlashCardRepositoryState {
  const FlashCardRepositoryState._({
    this.status = FlashCardRepositoryStatus.loading,
    this.items = const <FlashCard>[],
  });

  const FlashCardRepositoryState.loading() : this._();

  const FlashCardRepositoryState.success(List<FlashCard> items)
      : this._(status: FlashCardRepositoryStatus.success, items: items);

  const FlashCardRepositoryState.failure() : this._(status: FlashCardRepositoryStatus.failure);

  final FlashCardRepositoryStatus status;
  final List<FlashCard> items;
}
