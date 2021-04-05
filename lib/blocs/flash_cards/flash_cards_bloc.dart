import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:card_learning/data/irepository.dart';
import 'package:card_learning/exceptions/no_connection_exception.dart';
import 'package:card_learning/models/flashCard.dart';

import 'flash_cards_event.dart';
import 'flash_cards_state.dart';

class FlashCardBloc extends Bloc<FlashCardEvent, FlashCardState> {
  final IRepository<FlashCard> repository;

  FlashCardBloc({this.repository}) : super(FlashCardState());

  final List<FlashCard> _flashCards = [];
  int _currentFlashCardIndex = 0;

  @override
  Stream<FlashCardState> mapEventToState(FlashCardEvent event) async* {
    if (event is FlashCardEventCreate) {
      yield* _createNewCard(event);
    } else if (event is CardEventDeleteCard) {
      yield* _deleteCardById(event);
    } else if (event is CardEventCreatCardList) {
      yield* _createNewCardsFromList(event);
    }
  }

  Stream<FlashCardState> _createNewCard(FlashCardEventCreate e) async* {
    print("create new card ${e.id}, ${e.question}, ${e.solution}");
    yield FlashCardState(isFetching: true);
    try {
      await this._createCard(FlashCard(e.id, e.question, e.solution));
    } catch (e) {
      print("something went wrong");
    }
    yield FlashCardState(cards: this._flashCards);
  }

  Stream<FlashCardState> _createNewCardsFromList(CardEventCreatCardList e) async* {
    print("create new cards from list ${e.cards.length}");
    yield FlashCardState(isFetching: true);
    try {
      for (var card in e.cards) {
        await this._createCard(card);
      }
    } catch (e) {
      print("something went wrong");
    }
    yield FlashCardState(cards: _flashCards);
  }

  _deleteCardById(CardEventDeleteCard event) {}

  Future<void> _createCard(FlashCard flashCard) async {
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
