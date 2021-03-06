import 'dart:convert';

import 'package:card_learning/models/flash_card.dart';
import 'package:http/http.dart' as http;

class FetchRemoteService {
  static Future<List<FlashCard>> fetchRemoteDataFromJson(String url) async {
    var response = await http.get(Uri.parse(url));

    List<FlashCard> importedFlashCards = [];
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final result = jsonDecode(response.body);
      final data = result['data'];
      try {
        for (final card in data) {
          importedFlashCards.add(FlashCard.fromJson(card));
        }
      } on Exception {
        throw Exception('Could not import FlashCards from' + url);
      }
    } else {
      throw Exception('Failed to fetch from Url: ' + url);
    }

    return importedFlashCards;
  }
}
