import 'package:card_learning/models/learning_card_box_statistics.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

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
  num sortNumber;

  @HiveField(12)
  List<bool> testHistory = [];

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

  double performanceRating() {
    if (this.timesTested == 0) {
      return 0;
    }

    return this.timesGotRight / this.timesTested;
  }

  /// Tests if the card is matured.
  /// if minimum times tested is not met yet => false
  /// if maturedThreshold is met => true
  bool isMatured({double performanceThreshold = CardBoxStatistics.matureThreshold, int minimumTimesTested = CardBoxStatistics.minimumTimesTested}) {
    // if (this.timesTested <= minimumTimesTested) {
    //   return false;
    // }
    if (this.timesTested == 0) {
      return false;
    }

    return this.performanceRating() > performanceThreshold;
  }

  int numberOfGuessesRightInARow() {
    if (this.testHistory.length == 0) {
      return 0;
    }

    int timesRight = 0;
    for (int i = 0 ; i < this.testHistory.length ; i++) {
      bool iIsGuessedRight = this.testHistory.reversed.elementAt(i);
      if (iIsGuessedRight) {
        timesRight++;
      } else {
        break;
      }
    }

    return timesRight;
  }

  FlashCard.fromJson(Map<String, dynamic> jsonMap)
      : id = Utils.tryImportFromJson<String>('id', jsonMap, Uuid().v4().toString()),
        questionText = Utils.tryImportFromJson<String>('questionText', jsonMap, ''),
        questionAddition = Utils.tryImportFromJson<String>('questionAddition', jsonMap, ''),
        questionImage = Utils.tryImportFromJson<String>('questionImage', jsonMap, ''),
        solutionText = Utils.tryImportFromJson<String>('solutionText', jsonMap, ''),
        solutionAddition = Utils.tryImportFromJson<String>('solutionAddition', jsonMap, ''),
        solutionImage = Utils.tryImportFromJson<String>('solutionImage', jsonMap, ''),
        timesTested = Utils.tryImportFromJson<int>('timesTested', jsonMap, 0),
        timesGotRight = Utils.tryImportFromJson<int>('timesGotRight', jsonMap, 0),
        timesGotWrong = Utils.tryImportFromJson<int>('timesGotWrong', jsonMap, 0),
        lastTimeTested = Utils.tryImportFromJson<DateTime>('lastTimeTested', jsonMap, DateTime.now()),
        sortNumber = Utils.tryImportFromJson<int>('sortNumber', jsonMap, 0),
        testHistory = Utils.tryImportFromJson<List<bool>>('lastTests', jsonMap, []);
}
