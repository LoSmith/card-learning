import 'package:card_learning/blocs/cardLearning/cardLearning.dart';
import 'package:card_learning/data/flashCard_repository/flashCard_api_repository.dart';
import 'package:card_learning/data/flashCard_repository/hive_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'blocs/simple_bloc_observer.dart';
import 'data/flashCard_repository/flashCard_repository.dart';
import 'models/flashCard.dart';
import 'screens/tab_container_screen.dart';
import 'services/network_connectivity_service.dart';

const cardBoxName = 'spanish_flashCards';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FlashCardAdapter());
  final flashCardBox = await Hive.openBox<FlashCard>(cardBoxName);
  final networkConnectivityService = NetworkConnectivityService();

  Bloc.observer = SimpleBlocObserver();

  runApp(
    BlocProvider(
      create: (context) {
        return CardLearningBloc(
            repository: FlashCardRepository(
                source: FlashCardApiRepository(),
                cache: HiveRepository<FlashCard>(flashCardBox),
                hasConnection: networkConnectivityService.isConnected));
      },
      child: TabContainer(),
    ),
  );
}
