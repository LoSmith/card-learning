import 'package:card_learning/screens/fetch_remote_cards_list_screen.dart';
import 'package:flutter/material.dart';

class SelectListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // BlocProvider.of<CardLearningBloc>(context).add(
          //     CardLearningEventCreateCard(
          //         "id", "manual button question", 'manual button solution'));
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FetchRemoteCardsListScreen(
                  onSave: (fetchUrl) {},
                ),
              ));
        },
      ),
    );
  }
}
