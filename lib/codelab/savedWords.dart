import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class SavedWordsState extends State<SavedWordsRoute> {
  @override
  Widget build(BuildContext context) {
    final Iterable<ListTile> tiles = widget._bloc.getWords().map(
      (WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
          ),
        );
      },
    );
    final List<Widget> divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Suggestions'),
      ),
      body: ListView(children: divided),
    );
  }
}

class SavedWordsRoute extends StatefulWidget {
  final SaveWordBloc _bloc;

  SavedWordsRoute(this._bloc);

  @override
  State<StatefulWidget> createState() {
    return SavedWordsState();
  }
}

class SaveWordBloc {
  final Set<WordPair> wordList = Set();

  void addWord(WordPair word) {
    wordList.add(word);
  }

  void removeWord(WordPair word) {
    wordList.remove(word);
  }

  bool hasWord(WordPair word) {
    return wordList.contains(word);
  }

  Set<WordPair> getWords() => wordList;
}
