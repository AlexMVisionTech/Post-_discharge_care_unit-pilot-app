import 'package:flutter/material.dart';

class ChatGroupsScreen extends StatelessWidget {

  final List<Map<String, String>> chatGroups = [
    {
      'id': '1',
      'name': 'Cardiac Recovery',
      'description': 'Support group for patients recovering from heart surgery.',
    },
    {
      'id': '2',
      'name': 'Diabetes Management',
      'description': 'Tips and discussions on managing diabetes post-discharge.',
    },
    {
      'id': '3',
      'name': 'Post-Operative Care',
      'description': 'General advice and support for post-operative patients.',
    },
    {
      'id': '4',
      'name': 'Mental Health Support',
      'description': 'A safe space to discuss post-discharge mental health challenges.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Discharge Chat Groups'),
        backgroundColor: Colors.teal,
      ),
      body: chatGroups.isEmpty
          ? const Center(
              child: Text('No chat groups available at the moment.'),
            )
          : ListView.builder(
              itemCount: chatGroups.length,
              itemBuilder: (context, index) {
                var group = chatGroups[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal,
                    child: Text(
                      group['name']![0].toUpperCase(), 
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(group['name']!),
                  subtitle: Text(group['description']!),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GroupChatScreen(
                          groupId: group['id']!,
                          groupName: group['name']!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class GroupChatScreen extends StatelessWidget {
  final String groupId;
  final String groupName;

  const GroupChatScreen({super.key, required this.groupId, required this.groupName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(groupName),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text(
          'Welcome to the $groupName chat group! (Group ID: $groupId)',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
