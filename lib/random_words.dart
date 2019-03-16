import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/file_database.dart';
import 'package:flutter_app/idatabase.dart';
import 'package:flutter_app/word_pair_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final IDatabase _database = new FileDatabase();
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  var _saved = new Set<WordPair>();

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) {
            return Divider();
          }

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair wordPair) {
    final bool alreadySaved = _saved.contains(wordPair);
    return ListTile(
      title: Text(
        format(wordPair),
        style: _biggerFont,
      ),
      trailing: new IconButton(
        icon: new Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red[800] : null),
        onPressed: () {
          setState(() {
            if (alreadySaved) {
              _saved.remove(wordPair);
            } else {
              _saved.add(wordPair);
            }

            _database.save(toStringList(_saved));
          });
        },
      ),
      onTap: () {
        Fluttertoast.showToast(
          msg: "Pressed ${format(wordPair)}",
        );
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair wordPair) {
              return new ListTile(
                title: new Text(
                  format(wordPair),
                  style: _biggerFont,
                ),
                onTap: () {
                  setState(() {
                    _remove(wordPair);
                  });
                },
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return new Scaffold(
            appBar: new AppBar(
              title: const Text("Saved"),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }

  void _remove(WordPair wordPair) {
    if (_saved.contains(wordPair)) {
      _saved.remove(wordPair);
    }
    _database.save(toStringList(_saved));
  }

  Future<void> _loadSaved() {
    var data = _database.load();
    Set<WordPair> loadedData;

    return data.then((list) => {
          {
            loadedData = list
                .map((entry) =>
                    new WordPair(entry.split(" ")[0], entry.split(" ")[1]))
                .toSet(),
            _saved = _saved.union(loadedData),
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Startup Name Generator"),
        actions: <Widget>[
          new IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {
                _loadSaved().then((onValue) => _pushSaved());
              }),
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}
