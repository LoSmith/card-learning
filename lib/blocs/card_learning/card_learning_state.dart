import 'package:card_learning/models/flash_card.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CardLearningState {}

class CardLearningStateInitial extends CardLearningState {}
class CardLearningStateLoading extends CardLearningState {}
class CardLearningStateError extends CardLearningState {}
class CardLearningStateSuccess extends CardLearningState {
  CardLearningStateSuccess(this.currentCard);
  final FlashCard currentCard;
}



