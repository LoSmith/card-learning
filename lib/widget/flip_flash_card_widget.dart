import 'package:card_learning/model/learnCard.dart';
import 'package:flippable_box/flippable_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlipFlashCardWidget extends StatefulWidget {
  final FlashCard currentCard;

  const FlipFlashCardWidget({this.currentCard});

  @override
  _FlipFlashCardWidgetState createState() => _FlipFlashCardWidgetState();
}

class _FlipFlashCardWidgetState extends State<FlipFlashCardWidget>
    with SingleTickerProviderStateMixin {
  bool _isFlipped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: GestureDetector(
        onTap: () => _flipCard(),
        child: FlippableBox(
          front: _buildCard(
              this.widget.currentCard.question, 500, 250, Colors.green),
          back: _buildCard(
              this.widget.currentCard.solution, 500, 250, Colors.red),
          flipVt: true,
          isFlipped: _isFlipped,
          duration: 0.25,
        ),
      ),
    ));
  }

  void _flipCard() {
    setState(() => _isFlipped = !_isFlipped);
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
