import 'package:card_learning/models/learning_card_box.dart';

enum CardBoxListStatus { loading, success, failure, hasNetworkError }

class CardBoxListState {
  const CardBoxListState._({
    this.status = CardBoxListStatus.loading,
    this.items = const <LearningCardBox>[],
  });

  const CardBoxListState.loading() : this._();

  const CardBoxListState.success(List<LearningCardBox> items)
      : this._(status: CardBoxListStatus.success, items: items);

  const CardBoxListState.failure() : this._(status: CardBoxListStatus.failure);

  final CardBoxListStatus status;
  final List<LearningCardBox> items;
}
