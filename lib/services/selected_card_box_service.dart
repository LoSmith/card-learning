import 'package:card_learning/data/shared_prefs.dart';
import 'package:flutter/foundation.dart';

class SelectedCardBoxService {
  final _selectedCardBoxKey = "__SELECTED_CARD_BOX_KEY__";

  String getId() {
    try {
      return SharedPrefs.instance.getString(_selectedCardBoxKey).toString();
    } catch (e) {
      throw new ErrorDescription(
          "You need to initialize the SharedPrefs instance in your main to use it.");
    }
  }

  void setId(String cardBoxId) {
    try {
      SharedPrefs.instance.setString(_selectedCardBoxKey, cardBoxId);
    } catch (e) {
      throw new ErrorDescription(
          "You need to initialize the SharedPrefs instance in your main to use it.");
    }
  }
}
