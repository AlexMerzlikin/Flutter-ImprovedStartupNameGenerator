import 'package:english_words/english_words.dart';
import 'package:flutter_app/random_words/word_pair_extension.dart';

class SavedModel {
  final Set<WordPair> _saved = new Set<WordPair>();

  Set<WordPair> get saved => _saved;

  int get length => _saved.length;

  void addAll(Iterable<String> pairs) =>
      saved.addAll(pairs.map((entry) => toWordPair(entry)));

  void add(WordPair wordPair) => saved.add(wordPair);

  bool contains(WordPair wordPair) => saved.contains(wordPair);

  void remove(WordPair wordPair) {
    if (saved.contains(wordPair)) {
      saved.remove(wordPair);
    }
  }
}
