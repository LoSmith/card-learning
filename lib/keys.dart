import 'package:flutter/widgets.dart';

class Keys {
  // Tabs
  static final tabs = const Key('__tabs__');
  static final listSelectionTab = const Key('__listSelectionTab__');
  static final learningTab = const Key('__learningTab__');
  static final flashCardsListTab = const Key('__flashCardsListTab__');
  static final statsTab = const Key('__statsTab__');

  // Add Screen
  static final addTodoScreen = const Key('__addTodoScreen__');
  static final saveNewTodo = const Key('__saveNewTodo__');
  static final questionField = const Key('__questionField__');
  static final solutionField = const Key('__solutionField__');

  // Edit Screen
  static final editTodoScreen = const Key('__editTodoScreen__');
  static final saveTodoFab = const Key('__saveTodoFab__');

  // Fetch new Data Screen
  static final fetchNewData = const Key('__fetchNewData__');

  static const String LoadRemote = 'Load from remote source';
  static const String Settings = 'Settings';
  static const String DeleteAll = 'Delete all';
}
