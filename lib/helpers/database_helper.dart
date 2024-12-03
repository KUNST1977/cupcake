import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Nome das tabelas
const String registerTable = "registerTable";
const String productTable = "productTable";

/// Nome das colunas para registerTable
const String idColumn = "idColumn";
const String nameColumn = "nameColumn";
const String cpfColumn = "cpfColumn";
const String addressColumn = "addressColumn";
const String phoneColumn = "phoneColumn";
const String emailColumn = "emailColumn";
const String passColumn = "passColumn";

/// Nome das colunas para productTable
const String imageColumn = "imageColumn";
const String titleColumn = "titleColumn";
const String descriptionColumn = "descriptionColumn";
const String priceColumn = "priceColumn";

/// Inicializador do banco de dados
Future<Database> initializeDatabase() async {
  final databasesPath = await getDatabasesPath();
  final path = join(databasesPath, "Cupcake.db");

  return await openDatabase(
    path,
    version: 2, // Certifique-se de aumentar a versão ao alterar tabelas
    onCreate: (Database db, int version) async {
      // Criação da tabela de registro
      await db.execute(
        "CREATE TABLE $registerTable($idColumn INTEGER PRIMARY KEY, "
        "$nameColumn TEXT, "
        "$cpfColumn TEXT, "
        "$addressColumn TEXT, "
        "$phoneColumn TEXT, "
        "$emailColumn TEXT, "
        "$passColumn TEXT)",
      );
      print("Tabela $registerTable criada!");

      // Criação da tabela de produtos
      await db.execute(
        "CREATE TABLE $productTable($idColumn INTEGER PRIMARY KEY, "
        "$imageColumn TEXT, "
        "$titleColumn TEXT, "
        "$descriptionColumn TEXT, "
        "$priceColumn TEXT)",
      );
      print("Tabela $productTable criada!");
    },
  );
}
