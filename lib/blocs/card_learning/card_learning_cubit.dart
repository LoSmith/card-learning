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
  final List<FlashCard> _currentSessionCards = [];

  String get numberOfSessionCards => _currentSessionCards.length.toString();

  List<FlashCard> get cards => _currentSessionCards;

  CardLearningCubit(this._db) : super(CardLearningStateInitial());

  Future<void> switchToNextCard() async {
    if (this._currentSessionCards.isEmpty) {
      this._currentCardIndex = 0;
      emit(CardLearningStateError());
      // early exit, can't load cards, because no cards are available
      return;
    }

    if (this._currentCardIndex < this._currentSessionCards.length) {
      this._currentCardIndex++;
    } else {
      this._currentCardIndex = 0;
    }
    emit(CardLearningStateSuccess(await this._getCurrentCard()));
  }

  Future<void> fetchSessionCards(int numberOfCardsToLearn) async {
    try {
      bool isCurrentSessionUpToDate = await LearningSessionService().isCurrentSessionUpToDate();
      // bool isCurrentSessionUpToDate = false;
      if (isCurrentSessionUpToDate) {
        print('session already loaded');
        return;
      }

      this._currentSessionCards.clear();
      final cardsForCurrentSession =
          await CardFilterService(this._db).getCardsForTodaySession(numberOfCardsToLearn);
      if (cardsForCurrentSession.isNotEmpty) {
        this._currentSessionCards.addAll(cardsForCurrentSession);
        emit(CardLearningStateSuccess(await this._getCurrentCard()));
      } else {
        emit(CardLearningStateLoading());
      }
    } catch (e) {
      print(e.toString());
      emit(CardLearningStateError());
    }
  }

  Future<void> currentCardGuessedWrong() async {
    try {
      LearningCardBox box = await this._db.read(SelectedCardBoxService().getId());
      FlashCard updatedCard = await _setCurrentCardGuessed(isGuessedRight: false);

      box.cards.removeWhere((element) => element.id == updatedCard.id);
      box.cards.add(updatedCard);
      emit(CardLearningStateSuccess(await _getCurrentCard()));
    } on Exception {
      emit(CardLearningStateError());
    }
  }

  Future<void> currentCardGuessedRight() async {
    try {
      LearningCardBox box = await this._db.read(SelectedCardBoxService().getId());
      FlashCard updatedCard = await _setCurrentCardGuessed(isGuessedRight: true);

      box.cards.removeWhere((element) => element.id == updatedCard.id);
      box.cards.add(updatedCard);

      // if card is matured, remove from current session
      if (this._isCardTestHistoryXTimesRight(await this._getCurrentCard(), 3)) {
        this._currentSessionCards.removeWhere((element) => element.id == updatedCard.id);
      }
      if (this._currentSessionCards.isEmpty) {
        emit(CardLearningStateLoading());
      } else {
        emit(CardLearningStateSuccess(await _getCurrentCard()));
      }
    } on Exception {
      emit(CardLearningStateError());
    }
  }

  Future<FlashCard> _getCurrentCard() async {
    try {
      return this._currentSessionCards.elementAt(this._currentCardIndex);
    } catch (e) {
      return this._currentSessionCards.elementAt(0);
    }
  }

  Future<FlashCard> _setCurrentCardGuessed({required bool isGuessedRight}) async {
    FlashCard currentCard = await this._getCurrentCard();
    currentCard.timesTested++;
    currentCard.testHistory.add(isGuessedRight);
    if (isGuessedRight) {
      currentCard.timesGotRight++;
    } else {
      currentCard.timesGotWrong++;
    }
    currentCard.lastTimeTested = DateTime.now();
    return currentCard;
  }

  bool _isCardTestHistoryXTimesRight(FlashCard card, int timesRightThreshold) {
    return card.numberOfGuessesRightInARow() >= timesRightThreshold;
  }
}
