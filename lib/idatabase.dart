import 'dart:io';

abstract class IDatabase {
  Future<File> save(List<String> data);

  Future<List<String>> load();
}

