import 'package:flutter/material.dart';
import 'package:my_app/pages/book.dart';
import 'order_screen.dart';
import 'models/booking_info.dart';

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

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

    switch (index) {
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

  void _navigateToOrderScreen() {
    final pastBookings = [
      BookingInfo(
        eventType: 'Birthday',
        eventName: 'Lucas 1st',
        chairs: 30,
        tables: 10,
        tents: 2,
        gcashName: 'Maria Gomez',
        gcashNumber: '09123456780',
      ),
      BookingInfo(
        eventType: 'Wedding',
        eventName: 'J&K Ceremony',
        chairs: 100,
        tables: 50,
        tents: 10,
        gcashName: 'Kristine Dela Cruz',
        gcashNumber: '09998887777',
      ),
    ];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OrderScreen(bookings: pastBookings),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TrixTech'),
        backgroundColor: Colors.yellow[800],
      ),
      drawer: _buildDrawer(),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: listings.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: _buildListingCard(listings[index]),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildDrawer() {
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
          _buildDrawerItem(Icons.person, 'Profile', () {
            Navigator.pushNamed(context, '/Test');
          }),
          _buildDrawerItem(Icons.book, 'Book Events', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const book()));
          }),
          _buildDrawerItem(Icons.shopping_bag, 'Orders', _navigateToOrderScreen),
          _buildDrawerItem(Icons.logout, 'Logout', () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          }),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.yellow[800]),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildBottomNavigationBar() {
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

  Widget _buildListingCard(Listing listing) {
    return InkWell(
      onTap: _navigateToOrderScreen,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
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
      ),
    );
  }
}
