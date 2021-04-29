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
    return Scaffold(
      appBar: AppBar(
        title: Text('Load from Remote URL'),
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
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Paste your import file location here.",
                ),
                onSaved: (value) => _fetchUrl = value.toString(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
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
