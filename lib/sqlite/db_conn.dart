import 'package:crud_app/json_models/users_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  final databaseName = 'usersdb.db';
  String usersTable = "CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, mobile_number VARCHAR(20) NOT NULL, email VARCHAR(255) NOT NULL, password VARCHAR(255) NOT NULL, dob VARCHAR(20) NOT NULL);";
  Future<Database> initDB() async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async{
      await db.execute(usersTable);
    });
  }

  // Perform CRUD operations

  // Create a new user
  Future<int> createUser(Users user) async{
    Database db = await initDB();
    return db.insert('users', user.toMap());
  }
  // Read all users
  Future<List<Users>> getAllUsers() async{
    Database db = await initDB();
    List<Map<String, Object?>> mapUsers = await db.query('users');
    return mapUsers.map((e) => Users.fromMap(e)).toList();
  }
  // Update users
  // Future<int> updateUser(mobile, email, password, id) async{
  //   Database db = await initDB();
  //   return db.rawUpdate('UPDATE USERS SET mobile =?, email =?, password =?, id =?', [mobile, email, password, id]);
  // }

  Future<void> updateUser(Users user) async {
  final db = await initDB();
  await db.update(
    'users',
    user.toMap(),
    where: "id = ?",
    whereArgs: [user.id],
  );
}
  // Delete users
  Future<int> deleteUser(int id) async{
    Database db = await initDB();
    return db.delete('users', where: 'id =?', whereArgs: [id]);
  }
}