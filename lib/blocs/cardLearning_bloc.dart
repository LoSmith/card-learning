import 'package:bloc/bloc.dart';
import 'package:card_learning/blocs/states/cardLearning_state.dart';
import 'package:card_learning/data/irepository.dart';
import 'package:card_learning/domain/models/flashCard.dart';
import 'package:card_learning/exceptions/no_connection_exception.dart';

import 'events/cardLearning_event.dart';

class CardLearningBloc extends Bloc<CardLearningEvent, CardLearningState> {
  final IRepository<FlashCard> _userRepository;

  CardLearningBloc(this._userRepository) : super(CardLearningState());

  final List<FlashCard> _flashCards = [];
  int _currentUserIndex = 0;

  // @override
  // CardLearningState get initialState => CardLearningState();

  @override
  Stream<CardLearningState> mapEventToState(CardLearningEvent event) async* {
    if (event is CardLearningEventFetchNextFlashCard) {
      yield CardLearningState(isFetching: true);

      var newUser;

      try {
        newUser = await this._userRepository.get(this._currentUserIndex);
      } on NoConnectionException {
        yield CardLearningState(hasNetworkError: true);
        return;
      }

      this._currentUserIndex++;
      this._flashCards.add(newUser);

      yield CardLearningState(flashCards: this._flashCards);
    }
  }
}
