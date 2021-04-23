import 'package:card_learning/keys.dart';
import 'package:flutter/material.dart';

typedef OnSaveCallback = Function(String fetchUrl);

class FetchRemoteCardsScreen extends StatefulWidget {
  final OnSaveCallback onSave;

  FetchRemoteCardsScreen({
    required this.onSave,
  });

  @override
  _FetchRemoteCardsScreenState createState() => _FetchRemoteCardsScreenState();
}

class _FetchRemoteCardsScreenState extends State<FetchRemoteCardsScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _fetchUrl;

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
                initialValue:
                    'https://raw.githubusercontent.com/LoSmith/card-learning/main/assets/flashCardsLists/ES_EN.json',
                key: Keys.questionField,
                style: textTheme.headline5,
                decoration: InputDecoration(
                  hintText: "paste your public google sheets url here",
                ),
                onSaved: (value) => _fetchUrl = value.toString(),
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
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            widget.onSave(_fetchUrl);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
