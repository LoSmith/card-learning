import 'package:card_learning/data/shared_prefs.dart';
import 'package:card_learning/models/flash_card.dart';

class LearningSessionService {
  final _lastSessionDatetimeKey = "__LAST_SESSION_DATETIME_KEY__";

  Future<List<FlashCard>> getCardsForCurrentSession() async {
    return [];
  }

  Future<void> setLastSessionDateTime() async {
    try {
      DateTime nowDayBeginning = DateTime.now();
      SharedPrefs.instance.setString(_lastSessionDatetimeKey, nowDayBeginning.toString());
    } catch (e) {
      print('cant set SharedPrefs');
      throw(e);
    }
  }

  Future<DateTime> getLastSessionDateTime() async {
    try {
        return DateTime.parse(SharedPrefs.instance.getString(_lastSessionDatetimeKey).toString());
    } catch (e) {
        await this.setLastSessionDateTime();
        return DateTime.parse(SharedPrefs.instance.getString(_lastSessionDatetimeKey).toString());
    }
  }

  Future<bool> isCurrentSessionLoaded() async {
    DateTime lastTimeLoaded = await getLastSessionDateTime();
    DateTime now = DateTime.now();

    Duration sessionTimeInterval = Duration(days: 1);
    bool shouldNewSessionBeLoaded = lastTimeLoaded.add(sessionTimeInterval).isAfter(now);
    return !shouldNewSessionBeLoaded;
  }
}
