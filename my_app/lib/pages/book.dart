import 'package:flutter/material.dart';
import 'order_screen.dart';
import 'models/booking_info.dart';

class book extends StatefulWidget {
  const book({super.key});

  @override
  State<book> createState() => _bookState();
}

class _bookState extends State<book> {
  int _currentStep = 0;

  final _eventNameController = TextEditingController();
  final _chairsController = TextEditingController();
  final _tablesController = TextEditingController();
  final _tentsController = TextEditingController();
  final _gcashNameController = TextEditingController();
  final _gcashNumberController = TextEditingController();

  String? _selectedEventType;

  final List<String> _eventTypes = [
    'Birthday', 'Wedding', 'Corporate', 'Festival', 'Other'
  ];

  final List<String> _stepLabels = [
    "Event Type", "Event Details", "Payment Info"
  ];

  @override
  void dispose() {
    _eventNameController.dispose();
    _chairsController.dispose();
    _tablesController.dispose();
    _tentsController.dispose();
    _gcashNameController.dispose();
    _gcashNumberController.dispose();
    super.dispose();
  }

  void _handleNext() {
    if (_currentStep < 2) {
      setState(() => _currentStep++);
    } else {
      final booking = BookingInfo(
        eventType: _selectedEventType,
        eventName: _eventNameController.text,
        chairs: int.tryParse(_chairsController.text) ?? 0,
        tables: int.tryParse(_tablesController.text) ?? 0,
        tents: int.tryParse(_tentsController.text) ?? 0,
        gcashName: _gcashNameController.text,
        gcashNumber: _gcashNumberController.text,
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OrderScreen(booking: booking)),
      );

      _resetForm();
    }
  }

  void _resetForm() {
    setState(() {
      _currentStep = 0;
      _selectedEventType = null;
      _eventNameController.clear();
      _chairsController.clear();
      _tablesController.clear();
      _tentsController.clear();
      _gcashNameController.clear();
      _gcashNumberController.clear();
    });
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey[200],
      border: const OutlineInputBorder(),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType inputType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        decoration: _inputDecoration(label),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(height: 4, color: Colors.grey[300]),
            FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: _currentStep / 2,
              child: Container(height: 4, color: Colors.amber[800]),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(3, (index) {
            final isActive = _currentStep >= index;
            return InkWell(
              onTap: () => setState(() => _currentStep = index),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor:
                    isActive ? Colors.amber[800] : Colors.grey[400],
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: isActive ? Colors.black : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(_stepLabels[index], style: const TextStyle(fontSize: 12)),
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
        return DropdownButtonFormField<String>(
          value: _selectedEventType,
          decoration: _inputDecoration("Choose event type"),
          items: _eventTypes
              .map((type) => DropdownMenuItem(value: type, child: Text(type)))
              .toList(),
          onChanged: (value) => setState(() => _selectedEventType = value),
        );
      case 1:
        return Column(
          children: [
            _buildTextField("Event Name", _eventNameController),
            _buildTextField("Number of Chairs", _chairsController,
                inputType: TextInputType.number),
            _buildTextField("Number of Tables", _tablesController,
                inputType: TextInputType.number),
            _buildTextField("Number of Tents", _tentsController,
                inputType: TextInputType.number),
          ],
        );
      case 2:
        return Column(
          children: [
            _buildTextField("Gcash Name", _gcashNameController),
            _buildTextField("Gcash Number", _gcashNumberController,
                inputType: TextInputType.number),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Your Event", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.amber[800],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildStepIndicator(),
                      const SizedBox(height: 30),
                      _buildStepContent(),
                      const Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber[800],
                          padding: const EdgeInsets.symmetric(vertical: 16),
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
              ),
            );
          },
        ),
      ),
    );
  }
}
