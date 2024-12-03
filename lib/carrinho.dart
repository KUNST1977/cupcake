import 'package:flutter/material.dart';

class CarrinhoScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CarrinhoScreen({Key? key, required this.cartItems}) : super(key: key);

  @override
  State<CarrinhoScreen> createState() => _CarrinhoScreenState();
}

class _CarrinhoScreenState extends State<CarrinhoScreen> {
  double _calculateSubtotal() {
    return widget.cartItems.fold(
      0.0,
      (total, item) => total + (item['price'] * item['quantity']),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double subtotal = _calculateSubtotal();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Carrinho de Compras',
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Botão para continuar comprando
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context); // Volta para a vitrine
              },
              icon: const Icon(Icons.shopping_bag),
              label: const Text('Continuar Comprando'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
            ),
          ),
          // Lista de itens do carrinho
          Expanded(
            child: widget.cartItems.isEmpty
                ? const Center(
                    child: Text(
                      'Seu carrinho está vazio!',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = widget.cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              // Imagem do produto
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  item['image'],
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Detalhes do item
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['title'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Tamanho: ${item['size']}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      'R\$ ${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurpleAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Controle de quantidade
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (item['quantity'] > 1) {
                                        setState(() {
                                          item['quantity']--;
                                        });
                                      }
                                    },
                                    icon:
                                        const Icon(Icons.remove_circle_outline),
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  Text(
                                    '${item['quantity']}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        item['quantity']++;
                                      });
                                    },
                                    icon: const Icon(Icons.add_circle_outline),
                                    color: Colors.deepPurpleAccent,
                                  ),
                                ],
                              ),
                              // Botão de excluir
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    widget.cartItems.removeAt(index);
                                  });
                                },
                                icon: const Icon(Icons.delete_outline),
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          // Subtotal e botão de continuar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Subtotal
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Subtotal:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'R\$ ${subtotal.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Botão para finalizar o pedido
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Aqui você pode implementar a lógica de gravar o pedido no banco
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Pedido realizado com sucesso!'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Concluir Pedido',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
