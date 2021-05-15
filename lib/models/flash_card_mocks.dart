import 'flash_card.dart';

class FlashCardMocks {
  static FlashCard getDefaultMock() {
    return FlashCard("id", "questionText", "solutionText", DateTime.now());
  }
}