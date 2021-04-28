import 'package:hive/hive.dart';

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
