import 'package:flutter/material.dart';
import 'cadastro.dart';
import 'helpers/produtos_helper.dart';
import 'login.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Apaga o banco de dados existente
  // await deleteAppDatabase();
  await insertProducts();
  // await deleteProduct(5);

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    ),
  );
}

Future<void> deleteProduct(int i) async {
  final ProductHelper productHelper = ProductHelper();
  productHelper.deleteProduct(i);
}

Future<void> insertProducts() async {
  final ProductHelper productHelper = ProductHelper();

  // Lista de produtos a inserir
  final List<Map<String, dynamic>> products = [
    {
      "image":
          "https://s2-receitas.glbimg.com/qnGmSYvyFRY6VZUt8rCESvKtKps=/0x0:600x538/984x0/smart/filters:strip_icc()/s.glbimg.com/po/rc/media/2014/06/11/18_45_10_844_ultimate_chocolate_cupcakes_1_600.jpg",
      "title": "Cupcake de Chocolate",
      "description":
          "O 'Cupcake de Chocolate' é uma sublime tentação. Este pequeno, mas luxuoso cupcake é primorosamente banhado em uma generosa cobertura de chocolate ao leite, oferecendo uma experiência de sabor intensamente rica e indulgente.",
      "price": "16.90",
    },
    {
      "image":
          "https://s3.amazonaws.com/cdn.receita.guru/media/20240807093447/cup-800x450.webp",
      "title": "Cupcake de Baunilha",
      "description":
          "Tradicional cupcake de Baunilha, esse delicioso cupcake vai te surpreender com notas da baunilha e um leve toque de rum.",
      "price": "23.90",
    },
    {
      "image":
          "https://static.itdg.com.br/images/360-240/4e7329c862b6833fb761946e2f20f833/44038-original.jpg",
      "title": "Cupcake de Morango",
      "description":
          "Cobertura de Chantili e morangos cortados em forma de flores dão o toque sublime nesse delicioso cupcake de Morango.",
      "price": "23.90",
    },
    {
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPHHuwsgkJHqrls16KsV3C-mtkzSaTXhm1ZA&s",
      "title": "Cupcake de Café",
      "description":
          "Esse cupcake delicioso é para aqueles que apreciam o gosto inigualável do café.",
      "price": "19.90",
    },
    {
      "image":
          "https://www.sabornamesa.com.br/media/k2/items/cache/3abb66d58aa91d2b7b16f08ee38a95c0_XL.jpg",
      "title": "Cupcake de Limão",
      "description": "Delicioso cupcake de limão, refrescante e saboroso.",
      "price": "12.90",
    },
  ];

  // Verificar e inserir apenas produtos novos
  for (var product in products) {
    final existingProducts = await productHelper.getAllProduct();

    // Checa se o produto já existe no banco
    final exists = existingProducts.any((p) => p.title == product["title"]);

    if (!exists) {
      await productHelper.saveProduct(
        Product()
          ..image = product["image"]
          ..title = product["title"]
          ..description = product["description"]
          ..price = product["price"],
      );
      print("Produto '${product["title"]}' inserido com sucesso!");
    } else {
      print("Produto '${product["title"]}' já existe no banco.");
    }
  }
}

Future<void> deleteAppDatabase() async {
  final databasesPath = await getDatabasesPath();
  final path = join(databasesPath, "Cupcake.db");

  // Deletando o banco de dados com o caminho
  await deleteDatabase(path);
  print("Banco de dados deletado!");
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/images/cupcake_background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Cupcake Shop',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w800,
                    color: Colors.pinkAccent.shade400, // Cor pastel
                    shadows: const [
                      Shadow(
                        blurRadius: 5.0,
                        color: Colors.black26,
                        offset: Offset(4.0, 4.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                      ),
                      child: const Text(
                        'Entrar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Cadastro(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                      ),
                      child: const Text(
                        'Cadastro',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
