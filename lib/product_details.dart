import 'package:flutter/material.dart';

import 'carrinho.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 1;
  String _selectedSize = "P";

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 80.0),
            // Espaço para o rodapé fixo
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagem do produto com botão de voltar
                Stack(
                  children: [
                    Image.network(
                      product["image"],
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 50,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                    Positioned(
                      top: 16,
                      left: 0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 25,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Text(
                        product["title"],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 5,
                              color: Colors.black45,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Espaço para descrição
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    product["description"] ?? "Sem descrição disponível.",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Título "TAMANHOS"
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'TAMANHOS',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Botões de tamanho
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      _buildSizeButton("P"),
                      const SizedBox(width: 8),
                      _buildSizeButton("M"),
                      const SizedBox(width: 8),
                      _buildSizeButton("G"),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Preço em destaque
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'R\$ ${product["price"].toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          // Rodapé fixo
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Controle de quantidade
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (_quantity > 1) {
                            setState(() {
                              _quantity--;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove_circle_outline),
                        color: Colors.deepPurpleAccent,
                      ),
                      Text(
                        '$_quantity',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                        icon: const Icon(Icons.add_circle_outline),
                        color: Colors.deepPurpleAccent,
                      ),
                    ],
                  ),
                  // Botão adicionar
                  ElevatedButton(
                    onPressed: () {
                      // Adiciona o produto ao carrinho
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CarrinhoScreen(
                            cartItems: [
                              {
                                'image': widget.product['image'],
                                'title': widget.product['title'],
                                'size': _selectedSize,
                                'quantity': _quantity,
                                'price': widget.product['price'],
                              },
                            ],
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(5), // Borda quadrada
                      ),
                    ),
                    child: const Text(
                      'Adicionar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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

  Widget _buildSizeButton(String size) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedSize = size;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            _selectedSize == size ? Colors.deepPurpleAccent : Colors.grey[300],
        foregroundColor: _selectedSize == size ? Colors.white : Colors.black,
        minimumSize: const Size(50, 40), // Tamanho reduzido dos botões
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(size),
    );
  }
}
