import 'package:card_learning/blocs/card_learning/card_learning_cubit.dart';
import 'package:card_learning/data/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/card_box_list/card_box_list_cubit.dart';
import 'blocs/card_box_statistics/card_box_statistics_cubit.dart';
import 'blocs/card_list/card_list_cubit.dart';
import 'blocs/simple_bloc_observer.dart';
import 'data/database.dart';
import 'package:hive/hive.dart';

import 'screens/tab_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();

  Bloc.observer = SimpleBlocObserver();
  DatabaseConfig dbConfig = DatabaseConfig(true);
  final db = Database();
  await db.init(dbConfig);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => CardBoxListCubit(db)),
        BlocProvider(create: (BuildContext context) => CardListCubit(db)),
        BlocProvider(create: (BuildContext context) => CardBoxStatisticsCubit(db)),
        BlocProvider(create: (BuildContext context) => CardLearningCubit(db)),
      ],
      child: FlashCardLearningApp(),
    ),
  );
}

class FlashCardLearningApp extends StatefulWidget {
  @override
  _FlashCardLearningAppState createState() => _FlashCardLearningAppState();
}

class _FlashCardLearningAppState extends State<FlashCardLearningApp> {
  @override
  void dispose() async {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabScreen();
  }
}
