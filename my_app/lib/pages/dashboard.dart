import 'package:flutter/material.dart';
import 'order_screen.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 3) { // book now
      Navigator.pushNamed(context, '/Test');
    }
    else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const OrderScreen()),
      );
    }
    else if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const DashboardPage()),
      );
    }


    // You can add other index navigation cases here if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Text(
                'TrixTech Menu',
                style: TextStyle(
                  color: Colors.yellow[800],
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.yellow[800]),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/Test');
              },
            ),
            ListTile(
              leading: Icon(Icons.book, color: Colors.yellow[800]),
              title: const Text('Book Events'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag, color: Colors.yellow[800]),
              title: const Text('Orders'),
              onTap: () {
                Navigator.pop(context);
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.yellow[800]),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _buildMenuItem(Icons.event, 'Events', () {}),
            _buildMenuItem(Icons.photo, 'Gallery', () {

            }),
            _buildMenuItem(Icons.shopping_cart, 'Orders', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OrderScreen()),
              );
            }),
            _buildMenuItem(Icons.analytics, 'Reports', () {
              Navigator.pushNamed(context, '/Reports');
            }),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey[700],
        selectedFontSize: 12,
        unselectedFontSize: 12,
        iconSize: 28,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "book now",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "profile",
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: Colors.yellow[800]),
              const SizedBox(height: 10),
              Text(label, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
