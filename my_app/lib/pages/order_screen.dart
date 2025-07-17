import 'package:flutter/material.dart';
import 'models/booking_info.dart';

class OrderScreen extends StatelessWidget {
  final BookingInfo booking;

  const OrderScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Summary"),
        backgroundColor: Colors.amber[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Event Type: ${booking.eventType ?? 'Not specified'}"),
            Text("Event Name: ${booking.eventName}"),
            Text("Chairs: ${booking.chairs}"),
            Text("Tables: ${booking.tables}"),
            Text("Tents: ${booking.tents}"),
            const SizedBox(height: 20),
            Text("Gcash Name: ${booking.gcashName}"),
            Text("Gcash Number: ${booking.gcashNumber}"),
          ],
        ),
      ),
    );
  }
}
