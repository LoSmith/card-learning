import 'package:card_learning/keys.dart';
import 'package:card_learning/models/flashCard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef OnSaveCallback = Function(String fetchUrl);

class FetchRemoteCardsListScreen extends StatefulWidget {
  final List<FlashCard> flashCard;
  final OnSaveCallback onSave;

  FetchRemoteCardsListScreen({
    Key key,
    this.onSave,
    this.flashCard,
  });

  @override
  _FetchRemoteCardsListScreenState createState() => _FetchRemoteCardsListScreenState();
}

class _FetchRemoteCardsListScreenState extends State<FetchRemoteCardsListScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _fetchUrl;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('fetchRemote'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: '',
                key: Keys.questionField,
                style: textTheme.headline5,
                decoration: InputDecoration(
                  hintText: "paste your public google sheets url here",
                ),
                onSaved: (value) => _fetchUrl = value,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: Keys.saveNewTodo,
        tooltip: "fetchData",
        child: Icon(Icons.check),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSave(_fetchUrl);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
