import 'package:card_learning/blocs/flash_cards/flash_cards_cubit.dart';
import 'package:card_learning/blocs/flash_cards/flash_cards_state.dart';
import 'package:card_learning/screens/fetch_remote_cards_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlashCardsListScreen extends StatefulWidget {
  @override
  _FlashCardsListScreenState createState() => _FlashCardsListScreenState();
}

class _FlashCardsListScreenState extends State<FlashCardsListScreen> {
  @override
  Widget build(BuildContext context) {
    // CardController controller; //Use this to trigger swap.

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // final listUrl =
          //     "https://raw.githubusercontent.com/LoSmith/card-learning/main/assets/flashCardsLists/ES_EN.json";
          // context.read<FlashCardsCubit>().importJsonDataFromRemoteUrl(listUrl);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FetchRemoteCardsListScreen(
                  onSave: (fetchUrl) {
                    final listUrl =
                        "https://raw.githubusercontent.com/LoSmith/card-learning/main/assets/flashCardsLists/ES_EN.json";
                    context.read<FlashCardsCubit>().importJsonDataFromRemoteUrl(listUrl);
                  },
                ),
              ));
        },
      ),
      body: Column(children: [
        SizedBox(height: 15),
        Expanded(
          child: BlocBuilder<FlashCardsCubit, FlashCardsState>(
            builder: (context, state) {
              switch (state.status) {
                case FlashCardsStatus.loading:
                  return Center(child: CircularProgressIndicator());
                  break;

                case FlashCardsStatus.hasNetworkError:
                  return Text('Network error');
                  break;

                case FlashCardsStatus.success:
                  if (state.items?.isEmpty ?? true) {
                    return Text('No flashCards');
                  }
                  return _flashCardListView(state);
                  break;

                default:
                  return Column(
                      children: [Center(child: CircularProgressIndicator()), Text('test')]);
              }
            },
          ),
        ),
      ]),
    );
  }

  ListView _flashCardListView(FlashCardsState state) {
    return ListView(
      children: [
        Text(state.items.length.toString()),
        for (final flashCard in state.items)
          Column(
            children: [
              Text(
                flashCard.id,
                textAlign: TextAlign.center,
              ),
              Text(
                flashCard.question,
                textAlign: TextAlign.center,
              ),
              Text(
                flashCard.solution,
                textAlign: TextAlign.center,
              ),
            ],
          )
      ],
    );
  }
}
