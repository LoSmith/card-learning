import 'package:hive/hive.dart';

part 'flash_card.g.dart';

// build with:
// flutter packages pub run build_runner build
@HiveType(typeId: 0)
class FlashCard {
  @HiveField(0)
  final String id; // must be uid

  @HiveField(1)
  final String questionText;
  @HiveField(2)
  final String questionAddition;
  @HiveField(3)
  final String questionImage;

  @HiveField(4)
  final String solutionText;
  @HiveField(5)
  final String solutionAddition;
  @HiveField(6)
  final String solutionImage;

  @HiveField(7)
  final int timesTested;
  @HiveField(8)
  final int timesGotRight;
  @HiveField(9)
  final int timesGotWrong;
  @HiveField(10)
  final DateTime lastTimeTested;

  FlashCard(
    this.id,
    this.questionText,
    this.solutionText,
    this.lastTimeTested, {
    this.questionAddition = "",
    this.questionImage = "",
    this.solutionAddition = "",
    this.solutionImage = "",
    this.timesTested = 0,
    this.timesGotRight = 0,
    this.timesGotWrong = 0,
  });

  FlashCard.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'].toString(),
        questionText = jsonMap['questionText'].toString(),
        questionAddition = jsonMap['questionAddition'].toString(),
        questionImage = jsonMap['questionImage'].toString(),
        solutionText = jsonMap['solutionText'].toString(),
        solutionAddition = jsonMap['solutionAddition'].toString(),
        solutionImage = jsonMap['solutionImage'].toString(),
        timesTested = jsonMap['timesTested'],
        timesGotRight = jsonMap['timesGotRight'],
        timesGotWrong = jsonMap['timesGotWrong'],
        lastTimeTested = jsonMap['lastTimeTested'];
}
