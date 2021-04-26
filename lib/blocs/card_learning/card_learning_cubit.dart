import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_learning/data/database.dart';
import 'package:card_learning/models/flash_card.dart';
import 'package:card_learning/models/learning_card_box.dart';

import 'card_learning_state.dart';

class CardLearningCubit extends Cubit<CardLearningState> {
  final Database _db;
  int _currentCardIndex = 0;
  int get currentCardIndex => this._currentCardIndex;

  CardLearningCubit(this._db) : super(const CardLearningState.loading());

  Future<void> switchToNextCard() async {
    this._currentCardIndex++;
  }

  Future<void> fetchLatestFlashCardsFromCardBox(String boxId) async {
    if (boxId.isEmpty) {
      throw new Error();
    }
    try {
      LearningCardBox box = await this._db.read(boxId);
      emit(CardLearningState.success(box.cards));
    } catch (e) {
      print(e.toString());
      emit(const CardLearningState.failure());
    }
  }

  Future<void> currentCardGuessedWrong(String boxId) async {
    try {
      LearningCardBox box = await this._db.read(boxId);
      FlashCard badGuessedFlashCard = box.cards[_currentCardIndex];
      badGuessedFlashCard.timesTested++;
      badGuessedFlashCard.timesGotWrong++;
      badGuessedFlashCard.lastTimeTested = DateTime.now();

      box.cards.removeAt(_currentCardIndex);
      box.cards.add(badGuessedFlashCard);

      emit(CardLearningState.success(box.cards));
    } on Exception {
      emit(const CardLearningState.failure());
    }
  }
}
