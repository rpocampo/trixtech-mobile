import 'package:flutter/material.dart';
import 'models/booking_info.dart';

class OrderScreen extends StatelessWidget {

  final Map<String, dynamic>? bookingData;

  const OrderScreen({Key? key, this.bookingData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> rentals = [
      {
        'orderNo': 'R-1001',
        'name': 'Plastic Chairs',
        'price': 500,
        'status': 'Ongoing',
        'rating': 0,
        'image': 'https://via.placeholder.com/48',
      },
      {
        'orderNo': 'R-1002',
        'name': 'Tents - 10x10ft',
        'price': 1500,
        'status': 'Returned',
        'rating': 4,
        'image': 'https://via.placeholder.com/48',
      },
      {
        'orderNo': 'R-1003',
        'name': 'Folding Tables',
        'price': 800,
        'status': 'Cancelled',
        'rating': 0,
        'image': 'https://via.placeholder.com/48',
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


  final List<BookingInfo> bookings;

  OrderScreen({
    super.key,
    List<BookingInfo>? bookings,
    BookingInfo? booking,
  }) : bookings = bookings ?? (booking != null ? [booking] : []);

  @override
  Widget build(BuildContext context) {

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
          if (bookingData != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Material(
                color: Colors.yellow[100],
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'New Booking:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Event: ${bookingData!['eventType']} - ${bookingData!['eventName']}',
                      ),
                      Text('Chairs: ${bookingData!['chairs']}'),
                      Text('Tables: ${bookingData!['tables']}'),
                      Text('Tents: ${bookingData!['tents']}'),
                      Text(
                        'Gcash: ${bookingData!['gcashName']} (${bookingData!['gcashNumber']})',
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 48,
                                height: 48,
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rental $orderNo',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(name, overflow: TextOverflow.ellipsis),
                              Text(
                                '₱$price / day',
                                overflow: TextOverflow.ellipsis,
                              ),
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
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: getStatusColor(status).withOpacity(0.2),
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

        title: const Text("Order History"),
        backgroundColor: Colors.amber[800],
        centerTitle: true,
      ),
      body: bookings.isEmpty
          ? const Center(
        child: Text(
          "No orders yet.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: bookings.length,
        itemBuilder: (context, index) =>
            _buildBookingCard(bookings[index]),
        separatorBuilder: (_, __) => const SizedBox(height: 8),
      ),
    );
  }

  Widget _buildBookingCard(BookingInfo booking) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetail("Event Type", booking.eventType ?? 'Not specified'),
            _buildDetail("Event Name", booking.eventName),
            const SizedBox(height: 8),
            _buildDetail("Chairs", booking.chairs.toString()),
            _buildDetail("Tables", booking.tables.toString()),
            _buildDetail("Tents", booking.tents.toString()),
            const Divider(height: 24, thickness: 1),
            _buildDetail("Gcash Name", booking.gcashName),
            _buildDetail("Gcash Number", booking.gcashNumber),
          ],
        ),
      ),
    );
  }

  Widget _buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
            ),
          ),

        ],
      ),
    );
  }
}
