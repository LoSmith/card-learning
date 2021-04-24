import 'package:card_learning/blocs/card_box_statistics/card_box_statistics_cubit.dart';
import 'package:card_learning/blocs/selected_card_box/selected_card_box_cubit.dart';
import 'package:card_learning/models/learning_card_box_statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardBoxStatisticsScreen extends StatefulWidget {
  @override
  _CardBoxStatisticsScreenState createState() => _CardBoxStatisticsScreenState();
}

class _CardBoxStatisticsScreenState extends State<CardBoxStatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    // CardController controller; //Use this to trigger swap.
    var selectedBoxId = context.read<SelectedCardBoxCubit>().selectedCardBoxId;
    context.read<CardBoxStatisticsCubit>().calculateStatistics(selectedBoxId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics View'),
      ),
      body: BlocBuilder<CardBoxStatisticsCubit, CardBoxStatistics>(
        builder: (BuildContext context, CardBoxStatistics statistics) {
          if (!statistics.isValid) {
            return Center(child: Text('Something went wrong'));
          } else {
            return _statisticsViewWidget(context, statistics);
          }
        },
      ),
    );
  }

  Widget _statisticsViewWidget(BuildContext context, CardBoxStatistics statistics) {
    return Align(
      child: Column(
        children: [
          Text('isValid: ${statistics.isValid}'),
          Text('matureThreshold: ${statistics.matureThreshold}'),
          Text(''),
          Text('numberOfCards: ${statistics.numberOfCards}'),
          Text('numberOfCardsStudied: ${statistics.numberOfCardsStudied}'),
          Text('numberOfCardsMatured: ${statistics.numberOfCardsMatured}'),
        ],
      ),
    );
  }
}
