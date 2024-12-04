import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:post_discharge/Screens/Home_Screen/extrasettings.dart';
import 'package:post_discharge/Screens/Home_Screen/my_goals.dart';
import 'package:post_discharge/Screens/Home_Screen/user_record.dart';
import 'package:post_discharge/Screens/Home_Screen/weather.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String username = "Loading...";
  int engagementScore = 0;
  double bloodGlucose = 0.0;
  int heartRate = 0;
  String errorMessage = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final response = await http.get(Uri.parse('http://localhost/myapis/yu.php?action=fetch_user_data'));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['code'] == 1 && data['data'] != null) {
        
          var userData = data['data'][Index]; 

          setState(() {
            username = userData['name'] ?? "Unknown User"; 
            engagementScore = userData['engagementScore'] ?? 0; 
            bloodGlucose = userData['bloodGlucose']?.toDouble() ?? 0.0; 
            heartRate = userData['heartRate'] ?? 0; 
            errorMessage = ''; 
            isLoading = false; 
          });
        } else {
          setState(() {
            errorMessage = 'No user data found';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = 'Failed to load user data';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 20),
                      _buildUserProfile(),
                      const SizedBox(height: 20),
                      _buildHealthMetrics(),
                      const SizedBox(height: 20),
                      _buildHealthRecords(),
                      const SizedBox(height: 20),
                      _buildGoalsSection(),
                      if (errorMessage.isNotEmpty) 
                        Text(errorMessage, style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Get.to(() => Extrasettings());
              },
            ),
            Text(
              username,
              style: const TextStyle(
                color: Colors.pink,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.wb_sunny, color: Colors.orange),
            const Text('59.9°F'), 
            IconButton(
              icon: const Icon(Icons.keyboard_arrow_down),
              onPressed: () {
                Get.to(() => const WeatherScreen());
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUserProfile() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildEngagementScore(),
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage("assets/images/profile.png"),
            ),
            _buildRewardsIcon(),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          username,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.pink,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Text(
          'Health Data Last Updated 8/30 12:19 AM', 
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildEngagementScore() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: engagementScore / 100, 
                backgroundColor: Colors.orange.withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
            ),
            Text(
              '$engagementScore',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ],
        ),
        const Text(
          'Engagement\nScore',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.orange,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildRewardsIcon() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.pinkAccent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Icon(
            Icons.emoji_events,
            color: Colors.white,
            size: 30,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Rewards',
          style: TextStyle(
            color: Colors.pinkAccent,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildHealthMetrics() {
    return Card(
      color: Colors.orange.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Care\nPlan',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMetricCard('Blood Glucose', bloodGlucose.toString(), 'mg/dL'),
                _buildMetricCard('Heart Rate', heartRate.toString(), 'bpm'),
                
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String unit) {
    return Expanded(
      child: Card(
        color: Colors.blue.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Text(
                '$title\n($unit)',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHealthRecords() {
    return Column(
      children: [
        _buildRecordItem('My Health Record', Icons.description, () {
          Get.to(()=> const HealthRecordsScreen(userId: 2,));
        }),
        _buildRecordItem('My Health Survey', Icons.assignment, () {
         
        }),
        _buildRecordItem('My Medications', Icons.medication, () {
         
        }),
      ],
    );
  }

  Widget _buildRecordItem(String title, IconData icon, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: const Color(0xFFE8F7F4),
        child: ListTile(
          leading: Icon(icon, color: const Color(0xFF64D2BA)),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.pinkAccent,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.pinkAccent,
            size: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildGoalsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'My Goals',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () => Get.to(() => GoalsScreen()),
          child: Row(
            children: [
              const Text(
                'View More',
                style: TextStyle(color: Colors.grey),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ],
    );
  }
}