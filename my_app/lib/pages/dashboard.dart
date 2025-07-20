import 'package:flutter/material.dart';
import 'package:my_app/pages/book.dart';
import 'order_screen.dart';
import 'models/booking_info.dart';

// MODEL CLASS
class Listing {
  final String imagePath;
  final bool isNetworkImage;
  final String title;
  final String subtitle;
  final String price;

  Listing({
    required this.imagePath,
    required this.isNetworkImage,
    required this.title,
    required this.subtitle,
    required this.price,
  });
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  final List<Listing> listings = [
    Listing(
      imagePath: 'assets/birthday.jpg',
      isNetworkImage: false,
      title: 'Birthday',
      subtitle: '50 chairs\n20 tables\n5 tents',
      price: '\$782 total before taxes',
    ),
    Listing(
      imagePath: 'assets/wedding.jpg',
      isNetworkImage: false,
      title: 'Wedding',
      subtitle: '200 chairs\n100 tables\n20 tents',
      price: '\$520 total before taxes',
    ),
    Listing(
      imagePath: 'assets/corporate.jpg',
      isNetworkImage: false,
      title: 'Corporate',
      subtitle: '100 chairs\n50 tables\n10 tents',
      price: '\$782 total before taxes',
    ),
    Listing(
      imagePath: 'assets/baptism.jpeg',
      isNetworkImage: false,
      title: 'Festival',
      subtitle: '500 chairs\n200 tables\n50 tents',
      price: '\$950 total before taxes',
    ),
  ];

  void _navigateToOrderScreen() {
    final dummyBooking = BookingInfo(
      eventType: 'Birthday',
      eventName: 'Anna’s 18th',
      chairs: 50,
      tables: 20,
      tents: 5,
      gcashName: 'Anna Marie',
      gcashNumber: '09123456789',
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OrderScreen(booking: dummyBooking),
      ),
    );
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break; // Stay on Dashboard
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const book()));
        break;
      case 2:
        _navigateToOrderScreen();
        break;
      case 3:
        Navigator.pushNamed(context, '/Test');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TrixTech'),
        backgroundColor: Colors.yellow[800],
      ),
      drawer: buildDrawer(),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: listings.length,
        itemBuilder: (context, index) {
          final listing = listings[index];
          return Column(
            children: [
              buildListingCard(listing),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.black),
            child: Text(
              'TrixTech Menu',
              style: TextStyle(
                color: Colors.yellow[800],
                fontSize: 24,
              ),
            ),
          ),
          buildDrawerItem(Icons.person, 'Profile', () {
            Navigator.pushNamed(context, '/Test');
          }),
          buildDrawerItem(Icons.book, 'Book Events', () {

          }),
          buildDrawerItem(Icons.shopping_bag, 'Orders', _navigateToOrderScreen),
          buildDrawerItem(Icons.logout, 'Logout', () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          }),
        ],
      ),
    );
  }

  Widget buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.yellow[800]),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.amber[800],
      unselectedItemColor: Colors.grey[700],
      selectedFontSize: 12,
      unselectedFontSize: 12,
      iconSize: 28,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "book now"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "orders"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile"),
      ],
    );
  }

  Widget buildListingCard(Listing listing) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              listing.isNetworkImage
                  ? Image.network(
                listing.imagePath,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              )
                  : Image.asset(
                listing.imagePath,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Guest favorite',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Positioned(
                top: 12,
                right: 12,
                child: Icon(Icons.favorite_border, color: Colors.white),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  listing.title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(listing.subtitle, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                Text(listing.price, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}