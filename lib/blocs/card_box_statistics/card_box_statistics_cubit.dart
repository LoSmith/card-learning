import 'package:bloc/bloc.dart';
import 'package:card_learning/data/database.dart';
import 'package:card_learning/models/flash_card.dart';
import 'package:card_learning/models/learning_card_box.dart';
import 'package:card_learning/models/learning_card_box_statistics.dart';
import 'package:card_learning/services/selected_card_box_service.dart';

class CardBoxStatisticsCubit extends Cubit<CardBoxStatistics> {
  final Database _db;

  CardBoxStatisticsCubit(this._db) : super(CardBoxStatistics());

  Future<void> calculateCurrentStatistics() async {
    try {
      LearningCardBox selectedCardBox = await this._db.read(SelectedCardBoxService().getId());
      List<FlashCard> cards = selectedCardBox.cards;
      CardBoxStatistics statistics = CardBoxStatistics();
      statistics.numberOfCards = await this._calculateNumberOfCards(cards);
      statistics.numberOfCardsStudied = await this._countNumberOfCardsStudied(cards);
      statistics.numberOfCardsMatured = await this._countNumberOfMaturedCards(cards);
      statistics.percentageOfCardsStudied = await this._calculatePercentageOfCardsStudied(cards.length, statistics.numberOfCardsStudied);

      statistics.isValid = await this._validateStatistics();
      emit(statistics);
    } catch (e) {
      print(e.toString());
      emit(CardBoxStatistics());
    }
  }

  Future<int> _calculateNumberOfCards(List<FlashCard> cards) async {
    return cards.length;
  }

  Future<bool> _validateStatistics() async {
    return true;
  }

  Future<int> _countNumberOfMaturedCards(List<FlashCard> cards) async {
    var numberOfMaturedCards = 0;
    cards.forEach((element) {
      if (element.isMatured()) {
        numberOfMaturedCards++;
      }
    });
    return numberOfMaturedCards;
  }

  Future<int> _countNumberOfCardsStudied(List<FlashCard> cards) async {
    var numberOfTestedCards = 0;
    cards.forEach((element) {
      if (element.timesTested > 0) {
        numberOfTestedCards++;
      }
    });
    return numberOfTestedCards;
  }

  Future<double> _calculatePercentageOfCardsStudied(int length, int numberOfCardsStudied) async {
    if (length == 0) {
      return 0.0;
    }
    return (numberOfCardsStudied / length) * 100;
  }
}
