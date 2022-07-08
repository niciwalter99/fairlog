import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class Data {

  Data._privateConstructor();

  static final Data instance = Data._privateConstructor();


  Future get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future get _localFile async {
    final path = await _localPath;
    return File('$path/teamList5.txt');
  }

  Future writeCounter(List<String> teams) async {
    final file = await _localFile;
    /*final dir = Directory(await _localPath);
    dir.deleteSync(recursive: true);*/
    // Write the file
    return file.writeAsString(teams.join('\,'));
  }

   Future<String> readCounter() async {

    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      // If we encounter an error, return 0
      return '0';
    }
  }
}