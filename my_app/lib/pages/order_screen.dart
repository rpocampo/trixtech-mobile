import 'package:flutter/material.dart';
import 'models/booking_info.dart';

class OrderScreen extends StatelessWidget {
  final List<BookingInfo> bookings;

  OrderScreen({
    super.key,
    List<BookingInfo>? bookings,
    BookingInfo? booking,
  }) : bookings = bookings ?? (booking != null ? [booking] : []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
