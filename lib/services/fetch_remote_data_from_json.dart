import 'package:card_learning/models/flashCard.dart';
import 'package:http/http.dart' as http;

class FetchGsheetsService {
  Future<List<FlashCard>> fetchRemoteDataFromJson(String url) async {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

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
