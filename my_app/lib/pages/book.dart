import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: book(),
    debugShowCheckedModeBanner: false,
  ));
}

class book extends StatefulWidget {
  const book({super.key});

  @override
  State<book> createState() => _bookState();
}

class _bookState extends State<book> {
  int _currentStep = 0;

  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _chairsController = TextEditingController();
  final TextEditingController _tablesController = TextEditingController();
  final TextEditingController _tentsController = TextEditingController();
  final TextEditingController _cardNameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();

  String? _selectedEventType;

  final List<String> _eventTypes = [
    'Birthday',
    'Wedding',
    'Corporate',
    'Festival',
    'Other'
  ];

  Widget _buildStepProgress() {
    final List<String> _stepLabels = [
      "Event Type",
      "Event Details",
      "Payment Info"
    ];

    return Stack(
      alignment: Alignment.center,
      children: [
        // Background line
        Positioned(
          top: 20,
          left: 0,
          right: 0,
          child: Container(
            height: 4,
            color: Colors.grey[300],
          ),
        ),
        // Progress line
        Positioned(
          top: 20,
          left: 0,
          right: 0,
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: _currentStep / 2,
            child: Container(
              height: 4,
              color: Colors.amber[800],
            ),
          ),
        ),
        // Step indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(3, (index) {
            return InkWell(
              onTap: () {
                setState(() {
                  _currentStep = index;
                });
              },
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentStep >= index
                          ? Colors.amber[800]
                          : Colors.grey[400],
                    ),
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: _currentStep >= index
                            ? Colors.black
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _stepLabels[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Event Type",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedEventType,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(),
              ),
              items: _eventTypes.map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedEventType = value;
                });
              },
              hint: const Text("Choose event type"),
            ),
          ],
        );

      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Event Name",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            TextField(
              controller: _eventNameController,
              decoration: const InputDecoration(
                hintText: "Enter Event Name",
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            const Text("Number of Chairs",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            TextField(
              controller: _chairsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "e.g. 50",
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            const Text("Number of Tables",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            TextField(
              controller: _tablesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "e.g. 10",
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            const Text("Number of Tents",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            TextField(
              controller: _tentsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "e.g. 3",
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(),
              ),
            ),
          ],
        );

      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Gcash Name",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            TextField(
              controller: _cardNameController,
              decoration: const InputDecoration(
                hintText: "Enter full name",
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            const Text("Gcash Number",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            TextField(
              controller: _cardNumberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Enter card number",
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(),
              ),
            ),
          ],
        );

      default:
        return Container();
    }
  }

  void _handleNext() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
    } else {
      // Booking complete — show confirmation
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Booking Complete!"),
      ));
      setState(() {
        _currentStep = 0;
        _eventNameController.clear();
        _chairsController.clear();
        _tablesController.clear();
        _tentsController.clear();
        _cardNameController.clear();
        _cardNumberController.clear();
        _selectedEventType = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Your Event",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.yellow[800],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildStepProgress(),
            const SizedBox(height: 30),
            _buildStepContent(),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber[800],
                padding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
              ),
              onPressed: _handleNext,
              child: Text(
                _currentStep < 2 ? "Next" : "Finish",
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
