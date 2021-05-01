import 'package:flutter/material.dart';

class FlashCardSide extends StatelessWidget {
  final String mainText;
  final String additionText;
  final String image;

  FlashCardSide(this.mainText, this.additionText, this.image);

  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 250,
      color: Colors.green,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(this.mainText),
            Text(this.additionText),
            Text(this.image),
          ],
        ),
      ),
    );
  }
}
