import 'package:english_words/english_words.dart';

class SuggestionsModel {
  final _suggestions = <WordPair>[];

  List<WordPair> get suggestions => _suggestions;

  int get length => _suggestions.length;

  void generatePairs(int amount) => _addAll(generateWordPairs().take(amount));

  void _addAll(Iterable<WordPair> pairs) => suggestions.addAll(pairs);
}