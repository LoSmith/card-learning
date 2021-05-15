import 'package:card_learning/data/shared_prefs.dart';

class LearningSessionService {
  final _lastSessionDatetimeKey = "__LAST_SESSION_DATETIME_KEY__";

  Future<void> setLastSessionDateTime(DateTime setDateTime) async {
      await SharedPrefs.instance.setString(_lastSessionDatetimeKey, setDateTime.toString());
  }

  Future<DateTime> getLastSessionDateTime() async {
    String lastSessionDateTime = SharedPrefs.instance.getString(_lastSessionDatetimeKey).toString();
    if (lastSessionDateTime.isEmpty) {
      DateTime now = DateTime.now();
      await this.setLastSessionDateTime(now);
      lastSessionDateTime = now.toString();
    }

    return DateTime.parse(lastSessionDateTime);
  }

  Future<bool> isCurrentSessionUpToDate() async {
    DateTime lastTimeLoaded = await getLastSessionDateTime();
    DateTime dateNow = DateTime.now();
    Duration sessionTimeInterval = Duration(seconds: 10);

    DateTime dateAtWhichANewSessionNeedsToBeLoaded = lastTimeLoaded.add(sessionTimeInterval);
    bool sessionIsUpToDate = dateAtWhichANewSessionNeedsToBeLoaded.isAfter(dateNow);
    return sessionIsUpToDate;
  }
}
