import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'flashCard.g.dart';

@HiveType(typeId: 0)
class FlashCard {
  @HiveField(0)
  final String id; // must be uid

  @HiveField(1)
  final String question;

  @HiveField(2)
  final String solution;

  FlashCard(id, this.question, this.solution) : this.id = id ?? Uuid().v4();
}
