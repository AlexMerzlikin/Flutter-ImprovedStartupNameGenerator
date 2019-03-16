import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_app/database/idatabase.dart';

class FileDatabase implements IDatabase {

  final String fileName = "database.txt";

  @override
  Future<Iterable<String>> load() async{
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents.trim().split('\n');
    } catch (e) {
      return null;
    }
  }

  @override
  Future<File> save(Iterable<String> data) async {
    final file = await _localFile;

    var sink = file.openWrite();
    data.forEach((entry) => sink.write(entry + "\n"));
    sink.close();

    return file;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print("$path/$fileName");
    return File("$path/$fileName");
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
}
