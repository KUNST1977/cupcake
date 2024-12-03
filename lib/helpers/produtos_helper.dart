import 'package:cupcake/helpers/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

const String productTable = "productTable";

const String idColumn = "idColumn";
const String imageColumn = "imageColumn";
const String titleColumn = "titleColumn";
const String descriptionColumn = "descriptionColumn";
const String priceColumn = "priceColumn";

class ProductHelper {
  static final ProductHelper _instance = ProductHelper.internal();
  factory ProductHelper() => _instance;

  ProductHelper.internal();
  Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initializeDatabase();
      return _db!;
    }
  }

  Future<Product> saveProduct(Product product) async {
    Database dbCupcake = await db;
    product.id = await dbCupcake.insert(productTable, product.toMap());
    return product;
  }

  Future<Product?> getProduct(int id) async {
    Database dbCupcake = await db;
    List<Map> maps = await dbCupcake.query(productTable,
        columns: [
          idColumn,
          imageColumn,
          titleColumn,
          descriptionColumn,
          priceColumn
        ],
        where: "$idColumn = ?",
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Product.fromMap(maps.first as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<int> deleteProduct(int id) async {
    Database dbCupcake = await db;
    return await dbCupcake
        .delete(productTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateProduct(Product product) async {
    Database dbCupcake = await db;
    return await dbCupcake.update(productTable, product.toMap(),
        where: "$idColumn = ?", whereArgs: [product.id]);
  }

  Future<List<Product>> getAllProduct() async {
    Database dbCupcake = await db;
    List<Map<String, dynamic>> listMap =
        await dbCupcake.rawQuery("SELECT * FROM $productTable");
    List<Product> listProduct = List<Product>.empty(growable: true);
    for (Map<String, dynamic> m in listMap) {
      listProduct.add(Product.fromMap(m));
    }
    return listProduct;
  }

  Future<int?> getNumber() async {
    Database dbCupcake = await db;
    return Sqflite.firstIntValue(
        await dbCupcake.rawQuery("SELECT COUNT(*) FROM $productTable"));
  }

  Future close() async {
    Database dbCupcake = await db;
    dbCupcake.close();
  }
}

class Product {
  int? id;
  String? image;
  String? title;
  String? description;
  String? price;

  Product();

  Product.fromMap(Map<String, dynamic> map) {
    id = map[idColumn];
    image = map[imageColumn];
    title = map[titleColumn];
    description = map[descriptionColumn];
    price = map[priceColumn];
  }

  Map<String, dynamic> toMap() {
    return {
      idColumn: id,
      imageColumn: image,
      titleColumn: title,
      descriptionColumn: description,
      priceColumn: price
    };
  }

  @override
  String toString() {
    return "Product(id: $id, "
        "image: $image, "
        "title: $title,"
        "description: $description,"
        "price: $price";
  }
}
