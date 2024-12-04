import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

class FancyPlannerScreen extends StatefulWidget {
  final String patientName;

  FancyPlannerScreen({required this.patientName});

  @override
  _FancyPlannerScreenState createState() => _FancyPlannerScreenState();
}

class _FancyPlannerScreenState extends State<FancyPlannerScreen> {
  final List<String> encouragementMessages = [
    "Keep pushing, {name}! You're stronger than you think.",
    "Great job so far, {name}! You're making amazing progress.",
    "Every step counts, {name}. Keep it up!",
    "You're unstoppable, {name}! Stay focused on your goals.",
    "Believe in yourself, {name}! Recovery is within reach."
  ];

  late String encouragementMessage;

  final List<String> meals = [
    'Breakfast: Oatmeal with fruits and honey 🍓',
    'Lunch: Grilled chicken with steamed veggies 🥦',
    'Dinner: Baked salmon with quinoa and greens 🐟',
    'Snack: Greek yogurt with almonds and chia seeds 🥣'
  ];

  final List<String> exercises = [
    'Morning Yoga: 15 mins 🧘‍♀️',
    'Breathing Exercises: 10 mins 🫁',
    'Light Stretching: 20 mins 🤸‍♂️',
    'Evening Walk: 30 mins 🚶‍♀️'
  ];

  final List<Map<String, dynamic>> gpsRoutes = [
    {
      'name': 'Park Trail 🌳',
      'description': 'A relaxing route through the city park.',
      'location': LatLng(37.7749, -122.4194),
    },
    {
      'name': 'City Loop 🏙️',
      'description': 'A scenic loop around downtown.',
      'location': LatLng(37.7749, -122.4294), 
    },
    {
      'name': 'Lake Path 🌊',
      'description': 'A peaceful walk along the lake.',
      'location': LatLng(37.7849, -122.4094), 
    },
  ];

  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    _generateEncouragementMessage();
  }

  void _generateEncouragementMessage() {
    setState(() {
      var random = Random();
      encouragementMessage = encouragementMessages[random.nextInt(encouragementMessages.length)]
          .replaceAll('{name}', widget.patientName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Planner for ${widget.patientName}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEncouragementCard(),
            SizedBox(height: 20),
            _buildSectionHeader('Meals for Today'),
            _buildMealList(),
            SizedBox(height: 20),
            _buildSectionHeader('Physical Exercises'),
            _buildExerciseList(),
            SizedBox(height: 20),
            _buildSectionHeader('Training Routes'),
            _buildRouteList(),
          ],
        ),
      ),
    );
  }

  // Encouragement Card
  Widget _buildEncouragementCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.lightBlueAccent.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.mood, size: 50, color: Colors.white),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                encouragementMessage,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Section Header
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
    );
  }

  // Meal List
  Widget _buildMealList() {
    return Column(
      children: meals.map((meal) {
        return Card(
          margin: EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: Icon(Icons.restaurant, color: Colors.orangeAccent),
            title: Text(meal),
          ),
        );
      }).toList(),
    );
  }

  // Physical Exercise List
  Widget _buildExerciseList() {
    return Column(
      children: exercises.map((exercise) {
        return Card(
          margin: EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: Icon(Icons.fitness_center, color: Colors.greenAccent),
            title: Text(exercise),
          ),
        );
      }).toList(),
    );
  }

  // Training Route List
  Widget _buildRouteList() {
    return Column(
      children: gpsRoutes.map((route) {
        return Card(
          margin: EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: Icon(Icons.map, color: Colors.blueAccent),
            title: Text(route['name']),
            subtitle: Text(route['description']),
            onTap: () {
              _showRouteOnMap(route['location']);
            },
          ),
        );
      }).toList(),
    );
  }

  // Show Route on Map
  void _showRouteOnMap(LatLng location) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Route Map'),
          content: SizedBox(
            width: 300,
            height: 300,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: location,
                zoom: 15,
              ),
              markers: {
                Marker(markerId: MarkerId('route'), position: location),
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
