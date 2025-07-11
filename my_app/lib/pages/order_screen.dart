import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {'name': 'Tables', 'icon': Icons.table_bar, 'stock': 12},
      {'name': 'Chairs', 'icon': Icons.chair, 'stock': 50},
      {'name': 'Tents', 'icon': Icons.holiday_village, 'stock': 5},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Screen'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(item['icon'], size: 40, color: Colors.blue),
              title: Text(item['name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Text('Stock: ${item['stock']}'),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  // TODO: Navigate to detail page or perform action
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
