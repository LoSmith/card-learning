import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_learning/data/irepository.dart';
import 'package:card_learning/exceptions/no_connection_exception.dart';
import 'package:card_learning/models/flashCard.dart';

import 'flash_cards_state.dart';

class FlashCardsCubit extends Cubit<FlashCardsState> {
  final IRepository<FlashCard> repository;

  FlashCardsCubit({this.repository}) : super(const FlashCardsState.loading());

  final List<FlashCard> _flashCards = [];
  int _currentFlashCardIndex = 0;

  Future<void> fetchList() async {
    try {
      final items = this._flashCards;
      emit(FlashCardsState.success(items));
    } on Exception {
      emit(const FlashCardsState.failure());
    }
  }

  Future<void> createFlashCard(FlashCard flashCard) async {
    try {
      await this._saveNewCard(flashCard);
      final items = this._flashCards;
      emit(FlashCardsState.success(items));
    } on Exception {
      emit(const FlashCardsState.failure());
    }
  }

  Future<void> createFlashCardsFromList(List<FlashCard> flashCardsList) async {
    try {
      for (var card in flashCardsList) {
        await this._saveNewCard(card);
      }
      final items = this._flashCards;
      emit(FlashCardsState.success(items));
    } on Exception {
      emit(const FlashCardsState.failure());
    }
  }

  Future<void> _saveNewCard(FlashCard flashCard) async {
    var newFlashCard;

    try {
      await this.repository.create(flashCard);
      newFlashCard = await this.repository.read(_currentFlashCardIndex);
    } on NoConnectionException {
      print("something went wrong");
      return;
    }

    this._currentFlashCardIndex++;
    this._flashCards.add(newFlashCard);
  }
}
