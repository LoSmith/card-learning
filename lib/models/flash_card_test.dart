import 'package:test/test.dart';
import 'package:card_learning/models/flash_card.dart';
import 'flash_card_mocks.dart';

void main() {
  group('timesTestedRightInARow', () {
    test('3times right', () {
      FlashCard card = FlashCardMocks.getDefaultMock();
      card.testHistory.addAll([
        true,
        true,
        true]);
      expect(card.numberOfGuessesRightInARow(), 3);
    });
    test('4times right', () {
      FlashCard card = FlashCardMocks.getDefaultMock();
      card.testHistory.addAll([
        true,
        true,
        true,
        true
      ]);
      expect(card.numberOfGuessesRightInARow(), 4);
    });
    test('0 times right', () {
      FlashCard card = FlashCardMocks.getDefaultMock();
      card.testHistory.addAll([
        false,
        false,
        false,
        false
      ]);
      expect(card.numberOfGuessesRightInARow(), 0);
    });
    test('single element list', () {
      FlashCard card = FlashCardMocks.getDefaultMock();
      card.testHistory.addAll([
        true,
      ]);
      expect(card.numberOfGuessesRightInARow(), 1);
    });
    test('empty list', () {
      FlashCard card = FlashCardMocks.getDefaultMock();
      expect(card.numberOfGuessesRightInARow(), 0);
    });
  });

  group('performanceRating', () {
    test('simple 50/100', () {
      FlashCard card = FlashCardMocks.getDefaultMock();
      card.timesTested = 100;
      card.timesGotRight = 50;
      expect(card.performanceRating(), 0.5);
    });
    test('0times tested', () {
      FlashCard card = FlashCardMocks.getDefaultMock();
      card.timesTested = 0;
      card.timesGotRight = 50;
      expect(card.performanceRating(), 0);
    });
  });
}