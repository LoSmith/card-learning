import 'package:card_learning/data/flashCard_repository/flashCard_api_repository.dart';
import 'package:card_learning/data/hive_repository.dart';
import 'package:card_learning/screens/card_learning_screen.dart';
import 'package:card_learning/services/inetwork_connectivity_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/flashCard_repository/flashCard_repository.dart';
import 'domain/models/flashCard.dart';
import 'screens/wrapper_screen.dart';
import 'services/network_connectivity_service.dart';

const cardBoxName = 'cards';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FlashCardAdapter());
  final flashCardBox = await Hive.openBox<FlashCard>(cardBoxName);
  final networkConnectivityService = NetworkConnectivityService();

  runApp(MyApp(
    flashCardBox: flashCardBox,
    networkConnectivityService: networkConnectivityService,
  ));
}

// This widget is the root of your application.
class MyApp extends StatelessWidget {
  final Box<FlashCard> flashCardBox;
  final INetworkConnectivityService networkConnectivityService;

  const MyApp(
      {Key key,
      @required this.flashCardBox,
      @required this.networkConnectivityService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => FlashCardRepository(
              cache: FlashCardApiRepository(),
              source: HiveRepository<FlashCard>(this.flashCardBox),
              hasConnection: this.networkConnectivityService.isConnected),
        ),
      ],
      child: MaterialApp(
        title: 'FlipCard',
        theme: ThemeData.light(),
        home: CardLearningScreen(),
      ),
    );
  }
}
