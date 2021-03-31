import 'package:card_learning/models/flashCard.dart';
import 'package:flippable_box/flippable_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FlipFlashCard extends StatefulWidget {
  final FlashCard flashCard;
  // needs to be not final
  bool _isFlipped = false;

  FlipFlashCard({this.flashCard});

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
                this.widget.flashCard.question,
                'front supporting text',
                500,
                250,
                Colors.green,
                true,
                'images/bg.png'),
            back: _buildCard(this.widget.flashCard.solution,
                'back supporting text', 500, 250, Colors.red, false, ''),
            flipVt: false,
            isFlipped: this.widget._isFlipped,
            duration: 0.5,
          ),
        ));
  }

  void _flipCard() {
    setState(() => this.widget._isFlipped = !this.widget._isFlipped);
  }

  Widget _buildCard(
    String primaryTitle,
    String supportingText,
    double width,
    double height,
    Color color,
    bool isFront,
    String imagePath,
  ) {
    bool _renderRichMedia = imagePath != '' && imagePath != null;

    return Container(
      width: width,
      height: height,
      child: Card(
        elevation: 8,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              children: [
                // rich media
                if (_renderRichMedia) Image.asset(imagePath), Spacer(),
                if (!_renderRichMedia) Spacer(),
                // primary title
                Text(
                  primaryTitle,
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 3.0),
                ),
                const Divider(
                  height: 20,
                  thickness: 5,
                  indent: 20,
                  endIndent: 20,
                  color: Color.fromARGB(0, 1, 1, 1),
                ),
                // supporting text
                Text(
                  supportingText,
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
