import 'package:card_learning/models/flashCard.dart';
import 'package:gsheets/gsheets.dart';

class FetchGsheetsService {
  Future<List<FlashCard>> fetchFlashCardsFromGsheet(String sheetUrl) async {
  List<FlashCard> cards = [
    FlashCard("1", 'Front Text', 'Back Text'),
    FlashCard("2", 'I', 'Ich '),
    FlashCard("3", 'su', 'sein'),
    FlashCard("4", 'que', 'das'),
    FlashCard("5", 'que', 'das'),
    FlashCard("6", 'que', 'das'),
    FlashCard("7", 'que', 'das'),
  ];
    return cards;
  }
}
