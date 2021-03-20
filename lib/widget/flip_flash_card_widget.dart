import 'package:card_learning/model/learnCard.dart';
import 'package:flippable_box/flippable_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlipFlashCard extends StatefulWidget {
  FlashCard flashCard;

  FlipFlashCard({this.flashCard});

  @override
  _FlipFlashCardState createState() => _FlipFlashCardState();
}

class _FlipFlashCardState extends State<FlipFlashCard>
    with SingleTickerProviderStateMixin {
  // bool _isFlipped = false;
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
            isFlipped: this.widget.flashCard.isFlipped,
            duration: 0.25,
          ),
        ));
  }

  void _flipCard() {
    setState(() =>
        this.widget.flashCard.isFlipped = !this.widget.flashCard.isFlipped);
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
