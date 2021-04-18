import 'package:card_learning/models/flash_card.dart';
import 'package:hive/hive.dart';

part 'learning_card_box.g.dart';

// build with:
// flutter packages pub run build_runner build
//
@HiveType(typeId: 1)
class LearningCardBox {
  @HiveField(0)
  final String id;

  @HiveField(1)
  List<FlashCard> cards;

  LearningCardBox(
    this.id,
    this.cards,
  );
}
