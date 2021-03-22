import 'package:card_learning/model/learnCard.dart';
import 'package:flippable_box/flippable_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlipFlashCard extends StatefulWidget {
  FlashCard flashCard;

  FlipFlashCard({this.flashCard});
  bool _isFlipped = false;

  @override
  _FlipFlashCardState createState() => _FlipFlashCardState();
}

class _FlipFlashCardState extends State<FlipFlashCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GestureDetector(
          onTap: () => _flipCard(),
          child: FlippableBox(
            front: _buildCard(
                this.widget.flashCard.question, 500, 250, Colors.green),
            back: _buildCard(
                this.widget.flashCard.solution, 500, 250, Colors.red),
            flipVt: true,
            isFlipped: this.widget._isFlipped,
            duration: 0.25,
          ),
        ));
  }

  void _flipCard() {
    setState(() => this.widget._isFlipped = !this.widget._isFlipped);
  }

  Widget _buildCard(String label, double width, double height, Color color) {
    return Container(
        width: width,
        height: height,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.asset(
            'assets/bg.jpg',
            fit: BoxFit.cover,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
        ));

    // Container(
    //   decoration: ,
    //   // color: color,
    //   width: width,
    //   height: height,
    //   child: Center(
    //     child: Text(label, style: TextStyle(fontSize: 32)),
    //   ),
    // );
  }
}
