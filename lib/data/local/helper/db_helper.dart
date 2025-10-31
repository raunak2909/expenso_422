import 'dart:io';

import 'package:expenso_422/data/local/model/user_model.dart';
import 'package:expenso_422/domain/constants/app_constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  ///singleton
  DBHelper._();

  static DBHelper getInstance() => DBHelper._();

  Database? mDB;

  Future<Database> initDB() async {
    mDB ??= await openDB();
    return mDB!;
  }

  Future<Database> openDB() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDocDir.path, AppConstants.dbName);

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          "Create table ${AppConstants.userTable} ( ${AppConstants.columnUserId} integer primary key autoincrement, ${AppConstants.columnUserName} text, ${AppConstants.columnUserEmail} text, ${AppConstants.columnUserMobNo} text, ${AppConstants.columnUserPass} text)",
        );

        db.execute(
          "Create table ${AppConstants.expTable} ( ${AppConstants.columnExpId} integer primary key autoincrement, ${AppConstants.columnExpTitle} text, ${AppConstants.columnExpDesc} text, ${AppConstants.columnUserId} integer, ${AppConstants.columnExpType} integer, ${AppConstants.columnExpCatId} integer, ${AppConstants.columnExpAmt} real, ${AppConstants.columnExpBal} real, ${AppConstants.columnExpCreatedAt} text)",
        );
      },
    );
  }

  ///queries
  ///1->some error occurred
  ///2->email already exists
  ///3->user created successfully
  Future<int> createUser({required UserModel newUser}) async {
    var db = await initDB();

    if (!await checkIfUserAlreadyExists(email: newUser.email)) {
      int rowsEffected = await db.insert(
        AppConstants.userTable,
        newUser.toMap(),
      );
      return rowsEffected > 0 ? 3 : 1;
    } else {
      return 2;
    }
  }

  Future<bool> checkIfUserAlreadyExists({required String email}) async {
    var db = await initDB();

    List<Map<String, dynamic>> users = await db.query(
      AppConstants.userTable,
      where: "${AppConstants.columnUserEmail} = ?",
      whereArgs: [email],
    );

    return users.isNotEmpty;
  }

  Future<bool> authenticateUser({required String email, required String pass}) async {
    var db = await initDB();

    var users = await db.query(
      AppConstants.userTable,
      where:
          "${AppConstants.columnUserEmail} = ? AND ${AppConstants.columnUserPass} = ?",
      whereArgs: [email, pass],
    );

    return users.isNotEmpty;
  }
}
