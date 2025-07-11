import 'package:flutter/material.dart';
import 'Reports.dart';

class Reports extends StatelessWidget {
  const Reports({super.key});

  // Sample sales data for each month
  final List<Map<String, dynamic>> salesData = const [
    {'month': 'Jan', 'sales': 35},
    {'month': 'Feb', 'sales': 50},
    {'month': 'Mar', 'sales': 45},
    {'month': 'Apr', 'sales': 60},
    {'month': 'May', 'sales': 30},
    {'month': 'Jun', 'sales': 70},
    {'month': 'Jul', 'sales': 40},
    {'month': 'Aug', 'sales': 65},
    {'month': 'Sep', 'sales': 55},
    {'month': 'Oct', 'sales': 75},
    {'month': 'Nov', 'sales': 50},
    {'month': 'Dec', 'sales': 80},
  ];

  @override
  Widget build(BuildContext context) {
    final int maxSales = salesData.map((e) => e['sales'] as int).reduce((a, b) => a > b ? a : b);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          '📈 Monthly Sales Graph',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.blue.shade900, width: 2),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "📊 Sales from January to December",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.blue[900],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: salesData.length,
                  itemBuilder: (context, index) {
                    final item = salesData[index];
                    double barWidth = (item['sales'] / maxSales) * 220;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 50,
                            child: Text(
                              item['month'],
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                width: 220,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Container(
                                width: barWidth,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.blue[800],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "${item['sales']}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
