import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_learning/data/database.dart';
import 'package:card_learning/models/flash_card.dart';
import 'package:card_learning/models/learning_card_box.dart';
import 'package:card_learning/services/selected_card_box_service.dart';

import 'card_list_state.dart';

class CardListCubit extends Cubit<CardListState> {
  final Database _db;

  CardListCubit(this._db) : super(const CardListState.loading());

  Future<void> createCardInCurrentBox(FlashCard flashCard) async {
    try {
      var currentBoxId = SelectedCardBoxService().getId();
      LearningCardBox box = await this._db.read(currentBoxId);
      box.cards.add(flashCard);

      await this._db.create(currentBoxId, box);
      emit(CardListState.success(box.cards));
    } on Exception {
      emit(const CardListState.failure());
    }
  }

  Future<void> fetchCardsFromCurrentBox() async {
    try {
      var boxId = SelectedCardBoxService().getId();
      LearningCardBox box = await this._db.read(boxId);
      emit(CardListState.success(box.cards));
    } catch (e) {
      print(e.toString());
      emit(const CardListState.failure());
    }
  }

  Future<void> editCardInCurrentBox(FlashCard flashCard) async {
    try {
      var boxId = SelectedCardBoxService().getId();
      LearningCardBox box = await this._db.read(boxId);
      int oldFlashCardIndex = box.cards.indexWhere((element) => element.id == flashCard.id);
      box.cards.removeAt(oldFlashCardIndex);
      box.cards.add(flashCard);

      emit(CardListState.success(box.cards));
    } on Exception {
      emit(const CardListState.failure());
    }
  }

  Future<void> deleteCardInCurrentBox(FlashCard flashCard) async {
    try {
      var boxId = SelectedCardBoxService().getId();
      LearningCardBox box = await this._db.read(boxId);
      int cardIndex = box.cards.indexWhere((element) => element.id == flashCard.id);
      box.cards.removeAt(cardIndex);
      this._db.update(boxId, box);

      emit(CardListState.success(box.cards));
    } on Exception {
      emit(const CardListState.failure());
    }
  }

  Future<void> deleteAllCardsInCurrentBox() async {
    try {
      var boxId = SelectedCardBoxService().getId();
      LearningCardBox box = await this._db.read(boxId);
      box.cards.removeRange(0, box.cards.length);
      this._db.update(boxId, box);

      emit(CardListState.success(box.cards));
    } on Exception {
      emit(const CardListState.failure());
    }
  }
}
