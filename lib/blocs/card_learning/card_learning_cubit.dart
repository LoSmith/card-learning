import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_learning/data/database.dart';
import 'package:card_learning/models/flash_card.dart';
import 'package:card_learning/models/learning_card_box.dart';
import 'package:card_learning/services/card_filter_service.dart';
import 'package:card_learning/services/learning_session_service.dart';
import 'package:card_learning/services/selected_card_box_service.dart';

import 'card_learning_state.dart';

class CardLearningCubit extends Cubit<CardLearningState> {
  final Database _db;
  int _currentCardIndex = 0;

  int get currentCardIndex => this._currentCardIndex;

  final List<FlashCard> _currentSessionCards = [];

  CardLearningCubit(this._db) : super(CardLearningStateInitial());

  Future<FlashCard> getCurrentCard() async {
    try {
      return this._currentSessionCards.elementAt(currentCardIndex);
    } catch (e) {
      return this._currentSessionCards.elementAt(0);
    }
  }

  Future<void> switchToNextCard() async {
    if (this._currentSessionCards.isEmpty) {
      this._currentCardIndex = 0;
      return;
    }

    if (this.currentCardIndex < this._currentSessionCards.length) {
      this._currentCardIndex++;
    } else {
      this._currentCardIndex = 0;
    }
  }

  Future<void> fetchSessionCards(int numberOfCardsToLearn) async {
    try {
      bool isCurrentSessionCardsLoaded = await LearningSessionService().isCurrentSessionLoaded();
      // bool isCurrentSessionCardsLoaded = false;
      if (isCurrentSessionCardsLoaded) {
        print('session already loaded');
        return;
      }

      this._currentSessionCards.clear();
      final cardsForCurrentSession =
          await CardFilterService(this._db).getCardsForTodaySession(numberOfCardsToLearn);
      if (cardsForCurrentSession.isNotEmpty) {
        this._currentSessionCards.addAll(cardsForCurrentSession);
        emit(CardLearningStateSuccess(await this.getCurrentCard()));
      } else {
        emit(CardLearningStateLoading());
      }
    } catch (e) {
      print(e.toString());
      emit(CardLearningStateError());
    }
  }

  Future<FlashCard> updateCurrentCard(bool isGuessedRight) async {
    FlashCard currentCard = await this.getCurrentCard();
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
      FlashCard updatedCard = await updateCurrentCard(false);

      box.cards.removeWhere((element) => element.id == updatedCard.id);
      box.cards.add(updatedCard);
      emit(CardLearningStateSuccess(await getCurrentCard()));
    } on Exception {
      emit(CardLearningStateError());
    }
  }

  Future<void> currentCardGuessedRight() async {
    try {
      LearningCardBox box = await this._db.read(SelectedCardBoxService().getId());
      FlashCard updatedCard = await updateCurrentCard(true);

      box.cards.removeWhere((element) => element.id == updatedCard.id);
      box.cards.add(updatedCard);

      // if card is matured, remove from current session
      if (updatedCard.isMatured()) {
        this._currentSessionCards.removeWhere((element) => element.id == updatedCard.id);
      }
      if(this._currentSessionCards.isEmpty){
        emit(CardLearningStateLoading());
      } else {
        emit(CardLearningStateSuccess(await getCurrentCard()));
      }
    } on Exception {
      emit(CardLearningStateError());
    }
  }
}
