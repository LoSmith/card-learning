import 'package:flutter/material.dart';
import 'package:flippable_box/flippable_box.dart';

class LearningCard {
  String front;
  String back;

  LearningCard({this.front, this.back});
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlipCard',
      theme: ThemeData.dark(),
      home: LearnCardsPage(),
    );
  }
}

class LearnCardsPage extends StatefulWidget {
  @override
  _LearnCardsPageState createState() => _LearnCardsPageState();
}

class _LearnCardsPageState extends State<LearnCardsPage> {
  List<LearningCard> cards = [
    new LearningCard(front: 'front1', back: 'back1'),
    new LearningCard(front: 'front2', back: 'back2'),
    new LearningCard(front: 'front3', back: 'back3'),
    new LearningCard(front: 'front4', back: 'back4'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleCardPage(currentCard: cards[0],),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.arrow_left_rounded),
            label: 'Wrong',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.arrow_right_rounded),
            label: 'Right',
          ),
        ],
      ),
    );
  }
}

class SingleCardPage extends StatefulWidget {
  final LearningCard currentCard;

  const SingleCardPage({this.currentCard});

  @override
  _SingleCardPageState createState() => _SingleCardPageState();
}

class _SingleCardPageState extends State<SingleCardPage>
    with SingleTickerProviderStateMixin {
  bool _isFlipped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade100,
        body: Center(
          child: GestureDetector(
            onTap: () => setState(() => _isFlipped = !_isFlipped),
            child: FlippableBox(
              front: _buildCard("Front!", 500, 250, Colors.green),
              back: _buildCard("Back...", 500, 250, Colors.red),
              flipVt: true,
              isFlipped: _isFlipped,
              duration: 0.25,
            ),
          ),
        ));
  }

  Widget _buildCard(String label, double width, double height, Color color) {
    return Container(
      color: color,
      width: width,
      height: height,
      child: Center(
        child: Text(label, style: TextStyle(fontSize: 32)),
      ),
    );
  }
}
