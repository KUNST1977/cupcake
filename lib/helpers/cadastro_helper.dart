import 'package:cupcake/helpers/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

const String registerTable = "registerTable";

const String idColumn = "idColumn";
const String nameColumn = "nameColumn";
const String cpfColumn = "cpfColumn";
const String addressColumn = "addressColumn";
const String phoneColumn = "phoneColumn";
const String emailColumn = "emailColumn";
const String passColumn = "passColumn";

class RegisterHelper {
  static final RegisterHelper _instance = RegisterHelper.internal();
  factory RegisterHelper() => _instance;

  RegisterHelper.internal();
  Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initializeDatabase();
      return _db!;
    }
  }

  Future<Register> saveContact(Register register) async {
    Database dbCupcake = await db;
    register.id = await dbCupcake.insert(registerTable, register.toMap());
    return register;
  }

  Future<Register?> getRegister(int id) async {
    Database dbCupcake = await db;
    List<Map> maps = await dbCupcake.query(registerTable,
        columns: [
          idColumn,
          nameColumn,
          cpfColumn,
          addressColumn,
          phoneColumn,
          emailColumn,
          passColumn
        ],
        where: "$idColumn = ?",
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Register.fromMap(maps.first as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<int> deleteRegister(int id) async {
    Database dbCupcake = await db;
    return await dbCupcake
        .delete(registerTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateContact(Register register) async {
    Database dbCupcake = await db;
    return await dbCupcake.update(registerTable, register.toMap(),
        where: "$idColumn = ?", whereArgs: [register.id]);
  }

  Future<List<Register>> getAllRegister() async {
    Database dbCupcake = await db;
    List<Map<String, dynamic>> listMap =
        await dbCupcake.rawQuery("SELECT * FROM $registerTable");
    List<Register> listRegister = List<Register>.empty(growable: true);
    for (Map<String, dynamic> m in listMap) {
      listRegister.add(Register.fromMap(m));
    }
    return listRegister;
  }

  Future<int?> getNumber() async {
    Database dbCupcake = await db;
    return Sqflite.firstIntValue(
        await dbCupcake.rawQuery("SELECT COUNT(*) FROM $registerTable"));
  }

  Future close() async {
    Database dbCupcake = await db;
    dbCupcake.close();
  }
}

class Register {
  int? id;
  String? name;
  String? cpf;
  String? address;
  String? phone;
  String? email;
  String? pass;

  Register();

  Register.fromMap(Map<String, dynamic> map) {
    id = map[idColumn];
    name = map[nameColumn];
    cpf = map[cpfColumn];
    address = map[addressColumn];
    phone = map[phoneColumn];
    email = map[emailColumn];
    pass = map[passColumn];
  }

  Map<String, dynamic> toMap() {
    return {
      idColumn: id,
      nameColumn: name,
      cpfColumn: cpf,
      addressColumn: address,
      phoneColumn: phone,
      emailColumn: email,
      passColumn: pass
    };
  }

  @override
  String toString() {
    return "Register(id: $id, "
        "name: $name, "
        "cpf: $cpf,"
        "address: $address,"
        "phone: $phone, "
        "email: $email,"
        "pass: $pass)";
  }
}
