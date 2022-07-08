import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:math';

class DataBaseHelper {

  static final _dbName = 'fairlog.db';
  static final _dbVersion = 1;
  static final _tableName = 'fairlogMember';

  /*static final _teamTableName = 'teams';
  static final _teamdbName = 'fairlogteams.db';
  static final columnTeamName = 'team';*/

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnTeam = 'team';
  static final columnWrittenProtocol = 'writtenprotocols';


  DataBaseHelper._privateConstructor();

  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  static Database? _dataBase;
  Future<Database?> get database async {
    print("get");
    if(_dataBase != null) return _dataBase;

    _dataBase = await _initiateDatabase();
    return _dataBase;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version:  _dbVersion,
        onCreate: _onCreate

    );
  }


  Future? _onCreate(Database db, int version) {
    db.execute(
        '''
        CREATE TABLE $_tableName(
         $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnTeam TEXT NOT NULL,
        $columnWrittenProtocol TEXT NOT NULL)
        '''

    );
  }

  Future<int?> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db?.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>?> queryAll() async {
    Database? db = await instance.database;
    return await db?.query(_tableName);
  }

  Future<int> getWrittenProtocolOfName(int iD) async{
    Database? db = await instance.database;
    List<Map<String, Object?>>? test = await (db?.query(_tableName, where: '$columnId = ?', whereArgs: [iD]));
    String num = test![0][columnWrittenProtocol] as String;
    return int.parse(num);
  }

  Future<List<Map<String,dynamic>>?> getTeamMember(String team) async{
    Database? db = await instance.database;
    return await (db?.query(_tableName, where: '$columnTeam = ?', whereArgs: [team]));
  }

  Future<List<int>> getPossibleCandidates(List<int> iDs, String team) async{
    List<Map<String, dynamic>>? member = await getTeamMember(team);
    List<Map<String,dynamic>> candidates = [];
    List<int> endCandidates = [];

    List<int> writtenProtocols = [];

    //Database db = await instance.database;
    //db.execute('DELETE FROM $_tableName');

    int? length = member?.length;

    for(int i = 0; i < length!; i++) {
      if(iDs.contains(member![i][columnId])) {
        candidates.add(member![i]);
        /*if(int.parse(member[i][columnWrittenProtocol]) > 0) {
              candidates.add(member[i][columnId]);
            }*/
      }
    }

    for(int i = 0; i < candidates.length; i++) {
      writtenProtocols.add(int.parse(candidates[i][columnWrittenProtocol]));
    }

    int minProtocols = writtenProtocols.reduce(min);

    for(int i = 0; i < candidates.length; i++) {
      if (int.parse(candidates[i][columnWrittenProtocol]) == minProtocols) {
        endCandidates.add(candidates[i][columnId]);
      }
    }

      return endCandidates;
  }

  Future<bool?> iDExists (int iD) async {
    Database? db = await instance.database;
   // db.execute('DELETE FROM $_tableName');
    List<Map<String, Object?>>? test = await (db?.query(_tableName, where: '$columnId = ?', whereArgs: [iD]));
    return test?.isNotEmpty;
  }


  Future<Object?> getName (int iD) async {
    Database? db = await instance.database;
      List<Map<String, Object?>>? test = await (db?.query(
          _tableName, where: '$columnId=?',
          whereArgs: [iD]));
      return test![0][columnName];
  }

  Future update(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[columnId];
    return await db?.update(_tableName, row, where: '$columnId = ?', whereArgs: [id]); /* $columnName = ?*/
  }

  Future deleteTeam(String team) async{
    Database? db = await instance.database;
    return await db?.delete(_tableName, where: '$columnTeam = ?', whereArgs: [team]);
  }

  Future delete (int id) async {
    Database? db = await instance.database;
    return await db?.delete(_tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<String>> changeTeamNames(String originTeam, String newTeam) async {

    Database? db = await instance.database;
    List<Map<String, Object?>>? test = await (db?.query(
        _tableName, where: '$columnTeam=?',
        whereArgs: [originTeam]));
    int? length = test?.length;

    for(int i = 0; i < length!; i++) {

      await update({
        DataBaseHelper.columnId:test![i][columnId] ,
        DataBaseHelper.columnTeam: newTeam
      });
    }
    return [""];

  }
}