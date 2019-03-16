import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_app/database/idatabase.dart';

class FileDatabase implements IDatabase {

  @override
  Future<List<String>> load() async{
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents.trim().split('\n');
    } catch (e) {
      return null;
    }
  }

  @override
  Future<File> save(List<String> data) async {
    final file = await _localFile;

    var sink = file.openWrite();
    data.forEach((entry) => sink.write(entry + "\n"));
    sink.close();

    return file;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print("$path/database.txt");
    return File("$path/database.txt");
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
}
