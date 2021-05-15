import 'package:card_learning/data/database.dart';
import 'package:card_learning/models/flash_card.dart';
import 'package:card_learning/models/learning_card_box.dart';
import 'package:card_learning/util_functions.dart';
import 'selected_card_box_service.dart';

class CardFilterService {
  final Database _db;

  CardFilterService(this._db);

  Future<List<FlashCard>> getCardsForTodaySession(
      [int numberOfCardsForSession = 20, double percentageOfOldCards = 0.5]) async {
    final int maxOldCards = (numberOfCardsForSession * percentageOfOldCards).ceil();

    List<FlashCard> oldCards = await this.getOldCards(numberOfCardsForSession);
    List<FlashCard> newCards = await this.getNewCards(numberOfCardsForSession);

    if (oldCards.length >= maxOldCards) {
      oldCards = oldCards.sublist(0, maxOldCards);
    }
    final int maxNewCards = numberOfCardsForSession - oldCards.length;
    if (newCards.length >= maxNewCards) {
      newCards = newCards.sublist(0, maxNewCards);
    }

    print("oldCards:" + oldCards.length.toString());
    print("newCards:" + newCards.length.toString());
    print("---------");
    return [...oldCards, ...newCards];
  }

  Future<List<FlashCard>> getAllCurrentCards() async {
    LearningCardBox box = await this._db.read(SelectedCardBoxService().getId());
    return box.cards;
  }

  Future<List<FlashCard>> getNewCards(int numberOfCards) async {
    if (numberOfCards < 1) {
      throw new Error();
    }

    List<FlashCard> allCards = await this.getAllCurrentCards();
    final newCards = allCards.where((element) => element.timesTested == 0).toList();
    newCards.sort((a, b) => a.sortNumber.compareTo(b.sortNumber));
    return getFirstPossibleNumberOfItems<FlashCard>(newCards, numberOfCards);
  }

  Future<List<FlashCard>> getOldCards(int numberOfCards) async {
    if (numberOfCards < 1) {
      throw new Error();
    }

    List<FlashCard> allCards = await this.getAllCurrentCards();
    final oldCards = allCards.where((element) => element.timesTested != 0).toList();
    oldCards.sort((a, b) => a.performanceRating().compareTo(b.performanceRating()));
    return getFirstPossibleNumberOfItems<FlashCard>(oldCards, numberOfCards);
  }
}
