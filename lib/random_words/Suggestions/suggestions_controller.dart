import 'package:english_words/english_words.dart';
import 'package:flutter_app/random_words/Suggestions/suggestions_model.dart';

class SuggestionsController {
  final SuggestionsModel _suggestionsModel = new SuggestionsModel();

  int get length => _suggestionsModel.length;

  List<WordPair> get suggestions => _suggestionsModel.suggestions;

  void generatePairs(int amount) => _suggestionsModel.generatePairs(amount);
}