import 'package:card_learning/keys.dart';
import 'package:card_learning/models/flash_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

typedef OnSaveCallback = Function(String id, String question, String solution);

class AddEditScreen extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final FlashCard flashCard;

  AddEditScreen({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.flashCard,
  }) : super(key: key ?? Keys.addTodoScreen);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _uuid = Uuid();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _question;
  String _solution;

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
                initialValue: isEditing ? widget.flashCard.question : '',
                key: Keys.questionField,
                autofocus: !isEditing,
                style: textTheme.headline5,
                decoration: InputDecoration(
                  hintText: "newTodoHint",
                ),
                // validator: (val) {
                //   return "isempty";
                // },
                onSaved: (value) => _question = value,
              ),
              TextFormField(
                initialValue: isEditing ? widget.flashCard.solution : '',
                key: Keys.solutionField,
                maxLines: 10,
                style: textTheme.subtitle1,
                decoration: InputDecoration(
                  hintText: 'input tesxt hint',
                ),
                onSaved: (value) => _solution = value,
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
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();

            widget.onSave(_uuid.v1(), _question, _solution);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
