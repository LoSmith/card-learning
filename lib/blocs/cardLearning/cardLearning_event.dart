abstract class CardLearningEvent {}

class CardLearningEventCreateCard extends CardLearningEvent {
  final solution;
  final question;
  final id;

  CardLearningEventCreateCard(this.id, this.question, this.solution);
}

class CardLearningEventDeleteCard extends CardLearningEvent {
  final id;

  CardLearningEventDeleteCard(this.id);
}
