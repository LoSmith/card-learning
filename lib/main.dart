import 'package:card_learning/blocs/flash_cards/flash_card_repository_cubit.dart';
import 'package:card_learning/blocs/learning_card_boxes/learning_card_boxes_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/simple_bloc_observer.dart';
import 'data/database.dart';
import 'package:hive/hive.dart';

import 'screens/tab_container_screen.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  var db = Database()..init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => LearningCardBoxesCubit(db)),
        BlocProvider(create: (BuildContext context) => FlashCardRepositoryCubit(db))
      ],
      child: FlashCardLearningApp(),
    ),
  );

  Hive.close();
}

class BlockProvider {}
