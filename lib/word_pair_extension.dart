import 'package:english_words/english_words.dart';

String format(WordPair wordPair){
  return "${wordPair.first.replaceRange(0, 1, wordPair.first[0].toUpperCase())} "
      "${wordPair.second.replaceRange(0, 1, wordPair.second[0].toUpperCase())}";
}

List<String> toStringList(Set<WordPair> wordPairs){
  var list = new List<String>();
  wordPairs.forEach((entry) => list.add(format(entry)));
  return list;
}