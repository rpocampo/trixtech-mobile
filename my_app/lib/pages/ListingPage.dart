import 'package:flutter/material.dart';

class ListingPage extends StatefulWidget {
  const ListingPage({super.key});

  @override
  State<ListingPage> createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TrixTech"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          buildListingCard(
            imageUrl: 'https://source.unsplash.com/featured/?house,desert',
            title: 'Birthday',
            subtitle: '50 chairs\n20 tables\n5 tents',
            price: '\$782 total before taxes',
          ),
          const SizedBox(height: 20),
          buildListingCard(
            imageUrl: 'https://source.unsplash.com/featured/?cabin',
            title: 'Wedding',
            subtitle: '200 chairs\n100 tables\n20 tents',
            price: '\$520 total before taxes',
          ),
          buildListingCard(
            imageUrl: 'https://source.unsplash.com/featured/?house,desert',
            title: 'Corporate',
            subtitle: '100 chairs\n50 tables\n10 tents',
            price: '\$782 total before taxes',
          ),
          buildListingCard(
            imageUrl: 'https://source.unsplash.com/featured/?house,desert',
            title: 'Festival',
            subtitle: '500 chairs\n200 tables\n50 tents',
            price: '\$782 total before taxes',
          ),
        ],
      ),
    );
  }

  Widget buildListingCard({
    required String imageUrl,
    required String title,
    required String subtitle,
    required String price,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Guest favorite',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: IconButton(
                  icon: const Icon(Icons.favorite_border),
                  color: Colors.white,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                const SizedBox(height: 8),
                Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
