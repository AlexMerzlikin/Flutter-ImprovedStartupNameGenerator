import 'package:flutter_app/database/file_database.dart';
import 'package:test/test.dart';

void main() {
  group("Database", () {
    test("File should be saved", () {
      final database = new FileDatabase();
      final file = database.save(["1"]);
      file.then((f) => expect(f != null, true));
    });

    test("Data should be loaded", () {
      final database = new FileDatabase();
      database.save(["1"]);
      final data = database.load();
      data.then((list) => expect(list.contains("1"), true));
    });
  });
}
