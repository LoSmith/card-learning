import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectedCardBoxCubit extends Cubit<String> {
  final _selectedCardBoxKey = "__SELECTED_CARD_BOX_KEY__";
  String _selectedCardBoxId = "";
  SelectedCardBoxCubit() : super("") {
    this._updateSelectedCardBoxId();
  }

  String get selectedCardBoxId => this._selectedCardBoxId;

  Future<void> setSelectedCardBox(String cardBoxId) async {
    if (cardBoxId.isEmpty) {
      throw new Error();
    }
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_selectedCardBoxKey, cardBoxId);
      this._selectedCardBoxId = prefs.getString(_selectedCardBoxKey);
      emit(_selectedCardBoxId);
    } on Exception {
      emit("");
    }
  }

  Future<void> _updateSelectedCardBoxId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this._selectedCardBoxId = prefs.getString(_selectedCardBoxKey);
      emit(this._selectedCardBoxId);
    } on Exception {
      emit("");
    }
  }
}
