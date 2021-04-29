import 'package:hive/hive.dart';

import '../util_functions.dart';

part 'flash_card.g.dart';

// build with:
// flutter packages pub run build_runner build
@HiveType(typeId: 0)
class FlashCard {
  @HiveField(0)
  final String id; // must be uid

  @HiveField(1)
  String questionText;
  @HiveField(2)
  String questionAddition;
  @HiveField(3)
  String questionImage;

  @HiveField(4)
  String solutionText;
  @HiveField(5)
  String solutionAddition;
  @HiveField(6)
  String solutionImage;

  @HiveField(7)
  int timesTested;
  @HiveField(8)
  int timesGotRight;
  @HiveField(9)
  int timesGotWrong;
  @HiveField(10)
  DateTime lastTimeTested;

  @HiveField(11)
  int sortNumber;

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
    this.sortNumber = 0,
  });

  /// Tests if the card is matured.
  /// if minimum times tested is not met yet => false
  /// if maturedThreshold is met => true
  bool isMatured(double maturedThreshold, int minimumTimesTested) {
    if (this.timesTested <= minimumTimesTested) {
      return false;
    }
    if (this.timesTested == 0) {
      return false;
    }
    double maturingRating = (this.timesGotRight / this.timesTested);
    return maturingRating >= maturedThreshold;
  }

  FlashCard.fromJson(Map<String, dynamic> jsonMap)
      : id = tryFromJson<String>('id', jsonMap, ''),
        questionText = tryFromJson<String>('questionText', jsonMap, ''),
        questionAddition = tryFromJson<String>('questionAddition', jsonMap, ''),
        questionImage = tryFromJson<String>('questionImage', jsonMap, ''),
        solutionText = tryFromJson<String>('solutionText', jsonMap, ''),
        solutionAddition = tryFromJson<String>('solutionAddition', jsonMap, ''),
        solutionImage = tryFromJson<String>('solutionImage', jsonMap, ''),
        timesTested = tryFromJson<int>('timesTested', jsonMap, 0),
        timesGotRight = tryFromJson<int>('timesGotRight', jsonMap, 0),
        timesGotWrong = tryFromJson<int>('timesGotWrong', jsonMap, 0),
        lastTimeTested = tryFromJson<DateTime>('lastTimeTested', jsonMap, DateTime.now()),
        sortNumber = tryFromJson<int>('sortNumber', jsonMap, 0);
}
