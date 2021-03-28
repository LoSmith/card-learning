abstract class CardLearningEvent {}

class CardLearningEventFetchNextFlashCard extends CardLearningEvent {}

class CardLearningEventAddNewCard extends CardLearningEvent {
  final solution;
  final question;
  final id;

  CardLearningEventAddNewCard(this.id, this.question, this.solution);
}
