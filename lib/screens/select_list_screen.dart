import 'package:card_learning/blocs/flash_cards/flash_cards_cubit.dart';
import 'package:card_learning/models/flashCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'fetch_remote_cards_list_screen.dart';

class SelectListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<FlashCardsCubit>().importJsonDataFromRemoteUrl('someurl');
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => FetchRemoteCardsListScreen(
          //         onSave: (fetchUrl) {},
          //       ),
          //     ));
        },
      ),
    );
  }
}
