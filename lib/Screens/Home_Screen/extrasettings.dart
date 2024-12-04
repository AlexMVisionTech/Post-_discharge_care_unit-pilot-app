import 'package:flutter/material.dart';

void onMenuOptionSelected(BuildContext context, String value) {
  if (value == 'Personal Care Plan') {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Extrasettings()));
  } else if (value == 'Achievements & Progress') {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AchievementsPage()));
  } else if (value == 'Emergency Help') {
    Navigator.push(context, MaterialPageRoute(builder: (context) => EmergencyPage()));
  }
}

class Extrasettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Care Plan')),
      body: ListView(
        padding:const EdgeInsets.all(16),
        children:const [
          ListTile(
            title: Text('💊 Medication Reminder'),
            subtitle: Text('Take your prescribed medication every 6 hours.'),
            leading: Icon(Icons.medical_services),
          ),
          ListTile(
            title: Text('🏃‍♂️ Light Exercise'),
            subtitle: Text('Walk for 15 minutes daily to promote recovery.'),
            leading: Icon(Icons.directions_walk),
          ),
          ListTile(
            title: Text('💧 Stay Hydrated'),
            subtitle: Text('Drink at least 8 cups of water a day.'),
            leading: Icon(Icons.water),
          ),
          ListTile(
            title: Text('📅 Next Checkup'),
            subtitle: Text('Your next appointment is on 30th November 2024.'),
            leading: Icon(Icons.calendar_today),
          ),
        ],
      ),
    );
  }
}

class AchievementsPage extends StatefulWidget {
  @override
  _AchievementsPageState createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  double progress = 0.5; // Simulating progress (50%)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Achievements & Progress')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Progress:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.grey[300],
              color: Colors.green,
            ),
            SizedBox(height: 20),
            Text(
              'Achievements: You have completed ${progress * 100}% of your recovery tasks!',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  progress = (progress + 0.1) > 1.0 ? 1.0 : progress + 0.1;
                });
              },
              child: Text('Mark Progress'),
            ),
          ],
        ),
      ),
    );
  }
}

class EmergencyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Emergency Help')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'In case of an emergency, contact:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            const ListTile(
              title: Text('📞 Local Emergency Number'),
              subtitle: Text('Call 911 or your local emergency number.'),
              leading: Icon(Icons.phone),
            ),
            const ListTile(
              title: Text('🏥 Nearest Hospital'),
              subtitle: Text('City Health Hospital, 123 Main St, Open 24/7'),
              leading: Icon(Icons.local_hospital),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _simulateEmergencyCall(context);
              },
              child: Text('Call Emergency Services'),
            ),
          ],
        ),
      ),
    );
  }

  void _simulateEmergencyCall(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Calling Emergency Services...'),
          content: Text('Please wait while we connect you to emergency services.'),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
