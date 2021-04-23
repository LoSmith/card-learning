import 'package:card_learning/keys.dart';
import 'package:card_learning/models/flash_card.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

typedef OnSaveCallback = Function(String id, String question, String solution);

class AddEditScreen extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final FlashCard flashCard;

  AddEditScreen({
    required this.onSave,
    required this.isEditing,
    required this.flashCard,
  }) : super(key: Keys.addTodoScreen);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _question;
  late String _solution;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('editAdd'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: isEditing ? widget.flashCard.questionText : '',
                key: Keys.questionField,
                autofocus: !isEditing,
                style: textTheme.headline5,
                decoration: InputDecoration(
                  hintText: "newTodoHint",
                ),
                // validator: (val) {
                //   return "isempty";
                // },
                onSaved: (value) => _question = value.toString(),
              ),
              TextFormField(
                initialValue: isEditing ? widget.flashCard.solutionText : '',
                key: Keys.solutionField,
                maxLines: 10,
                style: textTheme.subtitle1,
                decoration: InputDecoration(
                  hintText: 'input tesxt hint',
                ),
                onSaved: (value) => _solution = value.toString(),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: isEditing ? Keys.saveTodoFab : Keys.saveNewTodo,
        tooltip: isEditing ? "saveChanges" : "addTodo",
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();

            widget.onSave(Uuid().v1(), _question, _solution);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
