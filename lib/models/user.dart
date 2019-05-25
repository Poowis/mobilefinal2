import 'package:sqflite/sqflite.dart';
import 'dart:async';

final String table = "users";
final String idCol = "_id";
final String useridCol = "userid";
final String nameCol = "name";
final String ageCol = "age";
final String passwordCol = "password";

class User {
  int id;
  String userid;
  String password;
  String name;
  String age;

  User({this.userid, this.password, this.name, this.age});
  User.formMap(Map<String, dynamic> map) {
    this.id = map[idCol];
    this.userid = map[useridCol];
    this.name = map[nameCol];
    this.age = map[ageCol];
    this.password = map[passwordCol];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      useridCol: userid,
      nameCol: name,
      ageCol: age,
      passwordCol: password,
    };
    return map;
  }
}

class UserProvider {
  Database db;
  Future open() async {
    db = await openDatabase("final.db", version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      create table $table (
        $idCol integer primary key autoincrement,
        $useridCol text not null unique,
        $nameCol text not null,
        $ageCol text not null,
        $passwordCol text not null
      )
      ''');
    });
  }

  Future<List<User>> getUsers() async {
    var res = await db.query(table,
        columns: [idCol, useridCol, nameCol, ageCol, passwordCol]);
    return res.isNotEmpty ? res.map((c) => User.formMap(c)).toList() : [];
  }

  Future<User> getUser(String userid) async {
    var res = await db.query(table,
        columns: [idCol, useridCol, nameCol, ageCol, passwordCol],
        where: '$useridCol = ?',
        whereArgs: [userid]);
    if (res.isNotEmpty) {
      return res.map((c) => User.formMap(c)).toList()[0];
    } else {
      return null;
    }
    
  }

  void insert(User user) async {
    await db.insert(table, user.toMap());
  }

  void updateUser(User user) async {
    await db
        .update(table, user.toMap(), where: '$idCol = ?', whereArgs: [user.id]);
  }

  Future<int> deleteUser(int id) async {
    return await db.delete(table, where: '$idCol = ?', whereArgs: [id]);
  }

  Future close() async => db.close();
}
