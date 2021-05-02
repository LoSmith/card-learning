import 'package:flutter/material.dart';

class FlashCardSide extends StatelessWidget {
  final String mainText;
  final String additionText;
  final String image;

  FlashCardSide(this.mainText, this.additionText, this.image);

  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 350,
      color: Colors.green,
      child: Card(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(this.mainText),
                  Text(this.additionText),
                ],
              ),
            ),
            FittedBox(
              fit: BoxFit.fill,
              child: Image.asset(
                'assets/images/box.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
