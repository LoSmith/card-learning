
import 'package:card_learning/screens/select_list_screen.dart';
import 'package:flutter/material.dart';

import '../keys.dart';
import 'learning_screen.dart';

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