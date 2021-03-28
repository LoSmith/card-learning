import 'package:bloc/bloc.dart';
import 'package:card_learning/blocs/states/cardLearning_state.dart';
import 'package:card_learning/data/irepository.dart';
import 'package:card_learning/domain/models/flashCard.dart';
import 'package:card_learning/exceptions/no_connection_exception.dart';

import 'events/cardLearning_event.dart';

class CardLearningBloc extends Bloc<CardLearningEvent, CardLearningState> {
  final IRepository<FlashCard> _flashCardRepository;

  CardLearningBloc(this._flashCardRepository) : super(CardLearningState());

  final List<FlashCard> _flashCards = [];
  int _currentFlashCardIndex = 0;

  // @override
  // CardLearningState get initialState => CardLearningState();

  @override
  Stream<CardLearningState> mapEventToState(CardLearningEvent event) async* {
    if (event is CardLearningEventAddNewCard) {
      var e = event;
      yield CardLearningState(isFetching: true);

      var newFlashCard;

      try {
        await this
            ._flashCardRepository
            .add(FlashCard(e.id, e.question, e.solution));
        newFlashCard = await this._flashCardRepository.get(e.id);
      } on NoConnectionException {
        print("something went wrong");
        yield CardLearningState(hasNetworkError: true);
        return;
      }

      this._currentFlashCardIndex++;
      this._flashCards.add(newFlashCard);

      yield CardLearningState(flashCards: this._flashCards);
    }

    if (event is CardLearningEventFetchNextFlashCard) {
      yield CardLearningState(isFetching: true);

      var newFlashCard;

      try {
        newFlashCard =
            await this._flashCardRepository.get(this._currentFlashCardIndex);
      } on NoConnectionException {
        yield CardLearningState(hasNetworkError: true);
        return;
      }

      this._currentFlashCardIndex++;
      this._flashCards.add(newFlashCard);

      yield CardLearningState(flashCards: this._flashCards);
    }
  }
}
