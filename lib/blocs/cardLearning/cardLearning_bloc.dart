import 'package:bloc/bloc.dart';
import 'package:card_learning/data/irepository.dart';
import 'package:card_learning/exceptions/no_connection_exception.dart';
import 'package:card_learning/models/flashCard.dart';

import 'cardLearning_event.dart';
import 'cardLearning_state.dart';

class CardLearningBloc extends Bloc<CardLearningEvent, CardLearningState> {
  final IRepository<FlashCard> _flashCardRepository;

  CardLearningBloc(this._flashCardRepository) : super(CardLearningState());

  final List<FlashCard> _flashCards = [];
  int _currentFlashCardIndex = 0;

  @override
  Stream<CardLearningState> mapEventToState(CardLearningEvent event) async* {
    if (event is CardLearningEventCreateCard) {
      yield* _createNewCardInRepository(event);
    } else if (event is CardLearningEventDeleteCard) {
      yield* _deleteCardInRespository(event);
          }
        }
      
        Stream<CardLearningState> _createNewCardInRepository(
            CardLearningEventCreateCard e) async* {
          yield CardLearningState(isFetching: true);
      
          var newFlashCard;
      
          try {
            await this
                ._flashCardRepository
                .create(FlashCard(e.id, e.question, e.solution));
            newFlashCard = await this._flashCardRepository.read(e.id);
          } on NoConnectionException {
            print("something went wrong");
            yield CardLearningState(hasNetworkError: true);
            return;
          }
      
          this._currentFlashCardIndex++;
          this._flashCards.add(newFlashCard);
      
          yield CardLearningState(flashCards: this._flashCards);
        }
          
        _deleteCardInRespository(CardLearningEventDeleteCard event) {}
}
