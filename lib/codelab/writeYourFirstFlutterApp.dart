import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:hello_flutter/codelab/savedWords.dart';

class WriteYourFirstFlutterAppRoute extends StatelessWidget {
  final SaveWordBloc _bloc = SaveWordBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CodeLab : WYFFA'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.list),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SavedWordsRoute(_bloc)))),
        ],
      ),
      body: Center(
        child: RandomWords(_bloc),
      ),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];

  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = widget._bloc.hasWord(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            widget._bloc.removeWord(pair);
          } else {
            widget._bloc.addWord(pair);
          }
        });
      },
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return Divider();
          }

          final int index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return _buildSuggestions();
  }
}

class RandomWords extends StatefulWidget {
  final SaveWordBloc _bloc;

  RandomWords(this._bloc);

  @override
  RandomWordsState createState() => RandomWordsState();
}
