import 'package:card_learning/blocs/cardLearning/cardLearning.dart';
import 'package:card_learning/data/flashCard_repository/flashCard_api_repository.dart';
import 'package:card_learning/data/flashCard_repository/hive_repository.dart';
import 'package:card_learning/keys.dart';
import 'package:card_learning/screens/add_edit_screen.dart';
import 'package:card_learning/screens/learning_screen.dart';
import 'package:card_learning/screens/select_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'blocs/simple_bloc_observer.dart';
import 'data/flashCard_repository/flashCard_repository.dart';
import 'models/flashCard.dart';
import 'services/network_connectivity_service.dart';

const cardBoxName = 'cards';

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

class TabContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      // color: Colors.yellow,
      home: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              SelectListScreen(),
              LearningScreen(),
              Container(
                child: Text('statsTab'),
                color: Colors.lightGreen,
              ),
            ],
          ),
          bottomNavigationBar: new TabBar(
            tabs: [
              Tab(
                key: Keys.listSelectionTab,
                text: 'Select List',
                icon: Icon(Icons.list),
              ),
              Tab(
                key: Keys.learningTab,
                text: 'Learn Cards',
                icon: Icon(Icons.inventory),
              ),
              Tab(
                key: Keys.statsTab,
                text: 'Statistics',
                icon: Icon(Icons.show_chart),
              ),
            ],
            labelColor: Colors.yellow,
            unselectedLabelColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Colors.yellow,
          ),
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}

// // This widget is the root of your application.
class CardLearninbfjdskfgApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlipCard',
      theme: ThemeData.light(),
      routes: {
        '/': (context) {
          return MultiBlocProvider(providers: [
            BlocProvider<CardLearningBloc>(
              create: (context) => CardLearningBloc(),
            )
          ], child: LearningScreen());
        }
      },
    );
  }
}
