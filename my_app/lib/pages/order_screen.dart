import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> rentals = [
      {
        'orderNo': 'R-1001',
        'name': 'Plastic Chairs',
        'price': 500,
        'status': 'Ongoing',
        'rating': 0,
        'image': 'https://via.placeholder.com/48'
      },
      {
        'orderNo': 'R-1002',
        'name': 'Tents - 10x10ft',
        'price': 1500,
        'status': 'Returned',
        'rating': 4,
        'image': 'https://via.placeholder.com/48'
      },
      {
        'orderNo': 'R-1003',
        'name': 'Folding Tables',
        'price': 800,
        'status': 'Cancelled',
        'rating': 0,
        'image': 'https://via.placeholder.com/48'
      },
    ];

    Color getStatusColor(String status) {
      switch (status) {
        case 'Returned':
          return Colors.green;
        case 'Ongoing':
          return Colors.amber;
        case 'Cancelled':
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('My Rentals', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search rentals...",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {},
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Rental List
          Expanded(
            child: ListView.separated(
              itemCount: rentals.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final rental = rentals[index];
                final String imageUrl = rental['image'] as String;
                final String name = rental['name'] as String;
                final String status = rental['status'] as String;
                final String orderNo = rental['orderNo'] as String;
                final num price = rental['price'] as num;
                final int rating = rental['rating'] as int;

                return Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        // Equipment Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            imageUrl,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Rental $orderNo',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              const SizedBox(height: 4),
                              Text(name),
                              Text('₱$price / day'),
                              const SizedBox(height: 8),
                              Row(
                                children: List.generate(5, (i) {
                                  return Icon(
                                    Icons.star,
                                    size: 18,
                                    color: i < rating
                                        ? Colors.amber
                                        : Colors.grey[300],
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                        // Status + Link
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color:
                                getStatusColor(status).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                status,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: getStatusColor(status),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () {
                                // TODO: Navigate to rental details
                              },
                              child: const Text(
                                "View rental details",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
