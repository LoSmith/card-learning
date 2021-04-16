import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_learning/data/database.dart';
import 'package:card_learning/exceptions/no_connection_exception.dart';
import 'package:card_learning/models/flash_card.dart';
import 'package:card_learning/services/fetch_remote_data_from_json.dart';

import 'flash_card_repository_state.dart';

class FlashCardRepositoryCubit extends Cubit<FlashCardRepositoryState> {
  final Database repository;

  FlashCardRepositoryCubit(this.repository) : super(const FlashCardRepositoryState.loading());

  final List<FlashCard> _flashCards = [];
  int _currentFlashCardIndex = 0;

  Future<void> fetchList() async {
    try {
      final items = this._flashCards;
      emit(FlashCardRepositoryState.success(items));
    } on Exception {
      emit(const FlashCardRepositoryState.failure());
    }
  }

  Future<void> importJsonDataFromRemoteUrl(String url) async {
    try {
      final remoteFlashCards = await FetchGsheetsService().fetchRemoteDataFromJson(url);
      this.createFlashCardsFromList(remoteFlashCards);

      final items = this._flashCards;
      emit(FlashCardRepositoryState.success(items));
    } on Exception {
      emit(const FlashCardRepositoryState.failure());
    }
  }

  Future<void> createFlashCard(FlashCard flashCard) async {
    try {
      await this._saveNewCard(flashCard);
      final items = this._flashCards;
      emit(FlashCardRepositoryState.success(items));
    } on Exception {
      emit(const FlashCardRepositoryState.failure());
    }
  }

  Future<void> createFlashCardsFromList(List<FlashCard> flashCardsList) async {
    try {
      for (var card in flashCardsList) {
        await this._saveNewCard(card);
      }
      final items = this._flashCards;
      emit(FlashCardRepositoryState.success(items));
    } on Exception {
      emit(const FlashCardRepositoryState.failure());
    }
  }

  Future<void> deleteAllCards() async {
    print('test');
  }

  Future<void> _saveNewCard(FlashCard flashCard) async {
    var newFlashCard;

    try {
      // await this.repository.create(flashCard);
      // newFlashCard = await this.repository.read(_currentFlashCardIndex);
    } on NoConnectionException {
      print("something went wrong");
      return;
    }

    this._currentFlashCardIndex++;
    this._flashCards.add(newFlashCard);
  }
}
