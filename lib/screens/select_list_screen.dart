import 'package:card_learning/blocs/cardLearning/cardLearning_bloc.dart';
import 'package:card_learning/blocs/cardLearning/cardLearning_event.dart';
import 'package:card_learning/screens/add_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddEditScreen(
                  isEditing: false,
                  onSave: (id, question, solution) {
                    BlocProvider.of<CardLearningBloc>(context).add(
                        CardLearningEventCreateCard(id, question, solution));
                  },
                ),
              ));
        },
      ),
    );
  }
}
