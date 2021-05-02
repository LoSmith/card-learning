import 'package:card_learning/data/database.dart';
import 'package:card_learning/models/flash_card.dart';
import 'package:card_learning/models/learning_card_box.dart';
import 'package:card_learning/util_functions.dart';
import 'selected_card_box_service.dart';

class CardFilterService {
  final Database _db;

  CardFilterService(this._db);

  Future<List<FlashCard>> getCardsForTodaySession(int numberOfCardsForSession,
      [double percentageOfOldCards = 0.5]) async {
    final int maxOldCards =
        (numberOfCardsForSession * percentageOfOldCards).ceil();
    final int maxNewCards = numberOfCardsForSession - maxOldCards;

    List<FlashCard> oldCards = await this.getOldCards(numberOfCardsForSession);
    List<FlashCard> newCards = await this.getNewCards(numberOfCardsForSession);

    //
    if (oldCards.length >= maxOldCards) {
      oldCards = oldCards.sublist(0, maxOldCards);
    }
    var stillOpenSlots = numberOfCardsForSession - oldCards.length;
    if (newCards.length >= maxNewCards + stillOpenSlots) {
      newCards = newCards.sublist(0, maxNewCards);
    }

    return [...oldCards, ...newCards];
  }

  Future<List<FlashCard>> getCurrentAllCards() async {
    LearningCardBox box = await this._db.read(SelectedCardBoxService().getId());
    return box.cards;
  }

  Future<List<FlashCard>> getNewCards(int numberOfCards) async {
    if (numberOfCards < 1) {
      throw new Error();
    }

    List<FlashCard> allCards = await this.getCurrentAllCards();
    final newCards =
        allCards.where((element) => element.timesTested == 0).toList();
    newCards
        .sort((a, b) => a.performanceRating().compareTo(b.performanceRating()));
    return getFirstPossibleNumberOfItems<FlashCard>(newCards, numberOfCards);
  }

  Future<List<FlashCard>> getOldCards(int numberOfCards) async {
    if (numberOfCards < 1) {
      throw new Error();
    }

    List<FlashCard> allCards = await this.getCurrentAllCards();
    final oldCards = allCards.where((element) => element.timesTested != 0).toList();
    return getFirstPossibleNumberOfItems<FlashCard>(oldCards, numberOfCards);
  }
}
