import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/flash_cards/flash_cards_cubit.dart';
import 'blocs/simple_bloc_observer.dart';
import 'data/hive_repository.dart';
import 'data/local_shared_prefs_repository/local_repository.dart';
import 'models/flashCard.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/tab_container_screen.dart';

const cardBoxName = 'spanish_flashCards';

void main() async {
  Bloc.observer = SimpleBlocObserver();

  await Hive.initFlutter();
  Hive.registerAdapter(FlashCardAdapter());
  final flashCardBox = await Hive.openBox<FlashCard>(cardBoxName);

  runApp(
    BlocProvider(
      create: (context) {
        return FlashCardsCubit(
            repository: LocalFlashCardRepository(
          source: HiveRepository<FlashCard>(flashCardBox),
        ))
          ..fetchList();
      },
      child: FlashCardLearningApp(),
    ),
  );
}
