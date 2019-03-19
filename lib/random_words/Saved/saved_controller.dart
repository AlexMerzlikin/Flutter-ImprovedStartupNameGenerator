import 'package:english_words/english_words.dart';
import 'package:flutter_app/database/file_database.dart';
import 'package:flutter_app/database/idatabase.dart';
import 'package:flutter_app/random_words/Saved/saved_model.dart';
import 'package:flutter_app/random_words/word_pair_extension.dart';

class SavedController {
  final SavedModel _savedModel = new SavedModel();
  final IDatabase _database = new FileDatabase();

  int get length => _savedModel.length;

  Set<WordPair> get saved => _savedModel.saved;

  bool contains(WordPair wordPair) => _savedModel.contains(wordPair);

  Future<Iterable<String>> load() {
    return _database.load();
  }

  void remove(WordPair wordPair) {
    _savedModel.remove(wordPair);
    _database.save(toStringList(saved));
  }

  void add(WordPair wordPair) {
    _savedModel.add(wordPair);
    _database.save(toStringList(saved));
  }

  void addAll(Iterable<String> pairs) => _savedModel.addAll(pairs);
}