import 'package:card_learning/models/learning_card_box.dart';

enum LearningCardBoxesStatus { loading, success, failure, hasNetworkError }

class LearningCardBoxesState {
  const LearningCardBoxesState._({
    this.status = LearningCardBoxesStatus.loading,
    this.items = const <LearningCardBox>[],
  });

  const LearningCardBoxesState.loading() : this._();

  const LearningCardBoxesState.success(List<LearningCardBox> items)
      : this._(status: LearningCardBoxesStatus.success, items: items);

  const LearningCardBoxesState.failure() : this._(status: LearningCardBoxesStatus.failure);

  final LearningCardBoxesStatus status;
  final List<LearningCardBox> items;
}
