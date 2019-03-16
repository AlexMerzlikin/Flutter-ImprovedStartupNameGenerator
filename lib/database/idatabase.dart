import 'dart:io';

abstract class IDatabase {
  Future<File> save(Iterable<String> data);

  Future<Iterable<String>> load();
}

