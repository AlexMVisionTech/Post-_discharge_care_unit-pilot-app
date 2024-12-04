import 'package:flutter/material.dart';
import 'package:post_discharge/Screens/profile/chat.dart';


class PostsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Community Dashboard')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildFeatureCard(
            context,
            icon: Icons.chat,
            title: 'Chat Groups',
            description: 'Connect with others sharing similar experiences',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ChatGroupsScreen()),
            ),
          ),
          _buildFeatureCard(
            context,
            icon: Icons.people,
            title: 'Local Support Groups',
            description: 'Find nearby support organizations',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => LocalSupportScreen()),
            ),
          ),
          _buildFeatureCard(
            context,
            icon: Icons.volunteer_activism,
            title: 'Volunteer Opportunities',
            description: 'Give back to the community',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => VolunteerScreen()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Theme.of(context).primaryColor),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}

class LocalSupportScreen extends StatelessWidget {
  final List<Map<String, String>> _supportGroups = [
    {
      'name': 'City Health Support Center',
      'address': 'Athi River Kenya',
      'phone': '(254) 708696356'
    },
    {
      'name': 'Community Wellness Network',
      'address': '456 Recovery Ave',
      'phone': '(254) 708696356'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Local Support Groups')),
      body: ListView.builder(
        itemCount: _supportGroups.length,
        itemBuilder: (context, index) {
          var group = _supportGroups[index];
          return Card(
            child: ListTile(
              title: Text(group['name']!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(group['address']!),
                  Text(group['phone']!),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class VolunteerScreen extends StatelessWidget {
  final List<Map<String, String>> _volunteerOpportunities = [
    {
      'title': 'Health Awareness Campaign',
      'organization': 'City Health Department',
      'description': 'Help spread health information in local communities'
    },
    {
      'title': 'Patient Support Volunteer',
      'organization': 'Wellness Center',
      'description': 'Provide support and companionship to patients'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Volunteer Opportunities')),
      body: ListView.builder(
        itemCount: _volunteerOpportunities.length,
        itemBuilder: (context, index) {
          var opportunity = _volunteerOpportunities[index];
          return Card(
            child: ListTile(
              title: Text(opportunity['title']!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(opportunity['organization']!),
                  Text(opportunity['description']!),
                ],
              ),
              trailing: ElevatedButton(
                child: Text('Apply'),
                onPressed: () {
                  
                },
              ),
            ),
          );
        },
      ),
    );
  }
}