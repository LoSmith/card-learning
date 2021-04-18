import 'package:card_learning/screens/card_box_list_screen.dart';
import 'package:flutter/material.dart';

import '../keys.dart';
import 'card_learning_screen.dart';
import 'card_list_screen.dart';

class TabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      // color: Colors.yellow,
      home: DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              CardBoxListScreen(),
              CardListScreen(),
              CardLearningScreen(),
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
                text: 'Select',
                icon: Icon(Icons.ac_unit),
              ),
              Tab(
                key: Keys.flashCardsListTab,
                text: 'CardList',
                icon: Icon(Icons.list),
              ),
              Tab(
                key: Keys.learningTab,
                text: 'Learn',
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
