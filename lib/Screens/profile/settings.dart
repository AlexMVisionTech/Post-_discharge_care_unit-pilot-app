import 'package:flutter/material.dart';

class UniqueSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: <Widget>[
          _buildProfileSection(),
          _buildSearchBar(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                _buildSectionTitle('General Settings'),
                _buildSwitchTile('Enable Notifications', true),
                _buildSwitchTile('Dark Mode', false),
                _buildSectionTitle('Account Settings'),
                _buildListTile('Change Password', Icons.lock, () {
                  
                }),
                _buildListTile('Privacy Policy', Icons.privacy_tip, () {
                 
                }),
                _buildSectionTitle('About'),
                _buildListTile('App Version', Icons.info, () {
                  
                }),
                _buildListTile('Contact Support', Icons.support, () {
                  
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.blue[100],
      child: const Row(
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('assets/images/profile.png'),
          ),
          SizedBox(width: 10),
          Text('Alex Mwera', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search settings...',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value) {
    return SwitchListTile(
      title: Text(title),
      value: value, 
      onChanged: (bool newValue) {
       
      },
    );
  }

  Widget _buildListTile(String title, IconData icon, Function onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      
    );
  }
}