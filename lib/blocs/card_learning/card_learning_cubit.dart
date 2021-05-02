import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_learning/data/database.dart';
import 'package:card_learning/models/flash_card.dart';
import 'package:card_learning/models/learning_card_box.dart';
import 'package:card_learning/services/card_filter_service.dart';
import 'package:card_learning/services/selected_card_box_service.dart';

import 'card_learning_state.dart';

class CardLearningCubit extends Cubit<CardLearningState> {
  final Database _db;
  int _currentCardIndex = 0;
  int get currentCardIndex => this._currentCardIndex;

  CardLearningCubit(this._db) : super(const CardLearningState.loading());

  Future<void> switchToNextCard() async {
    LearningCardBox box = await this._db.read(SelectedCardBoxService().getId());
    int maxCardIndex = box.cards.length - 1;
    if (this.currentCardIndex < maxCardIndex) {
      this._currentCardIndex++;
    } else {
      this._currentCardIndex = 0;
    }
  }

  Future<void> fetchAllCurrentFlashCards() async {
    try {
      LearningCardBox box = await this._db.read(SelectedCardBoxService().getId());
      emit(CardLearningState.success(box.cards));
    } catch (e) {
      print(e.toString());
      emit(const CardLearningState.failure());
    }
  }

  Future<void> fetchCardsForDailySession(int numberOfCardsToLearn) async {
    try {
      List<FlashCard> cards = await CardFilterService(this._db).getCardsForTodaySession(numberOfCardsToLearn);
      emit(CardLearningState.success(cards));
    } catch (e) {
      print(e.toString());
      emit(const CardLearningState.failure());
    }
  }

  Future<FlashCard> updateCurrentCard(LearningCardBox box, bool isGuessedRight) async {
    FlashCard currentCard = box.cards[_currentCardIndex];
    currentCard.timesTested++;
    if (isGuessedRight) {
      currentCard.timesGotRight++;
    } else {
      currentCard.timesGotWrong++;
    }
    currentCard.lastTimeTested = DateTime.now();
    return currentCard;
  }

  Future<void> currentCardGuessedWrong() async {
    try {
      LearningCardBox box = await this._db.read(SelectedCardBoxService().getId());
      FlashCard updatedCard = await updateCurrentCard(box, false);

      box.cards.removeAt(_currentCardIndex);
      box.cards.add(updatedCard);

      emit(CardLearningState.success(box.cards));
    } on Exception {
      emit(const CardLearningState.failure());
    }
  }

  Future<void> currentCardGuessedRight() async {
    try {
      LearningCardBox box = await this._db.read(SelectedCardBoxService().getId());
      FlashCard updatedCard = await updateCurrentCard(box, true);

      box.cards.removeAt(_currentCardIndex);
      box.cards.add(updatedCard);

      emit(CardLearningState.success(box.cards));
    } on Exception {
      emit(const CardLearningState.failure());
    }
  }
}
