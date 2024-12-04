import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_discharge/Screens/authentication/LoginScreen/login.dart';
import 'package:post_discharge/Screens/profile/posts.dart';
import 'package:post_discharge/Screens/profile/settings.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _TabbedProfileScreenState createState() => _TabbedProfileScreenState();
}

class _TabbedProfileScreenState extends State<MyProfileScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    ProfileInfoTab(),
    ProfilePostsTab(),
    ProfileSettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Info'),
          BottomNavigationBarItem(icon: Icon(Icons.post_add), label: 'Posts'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class ProfileInfoTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildCoverPhoto(),
          _buildProfileCard(),
          _buildProfileDetails(),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildCoverPhoto() {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/setting.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: const Center(
        child: Text(
          'Welcome to Your Profile',
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile.png'), 
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  <Widget>[
                  Text(
                    'Alex Mwera',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'User ID: 413456',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Icon(Icons.edit, color: Colors.deepOrange),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        children: <Widget>[
          _buildDetailRow('Full Name', 'Alex Mwera'),
          _buildDetailRow('Email', 'alexmwera@gmail.com'),
          _buildDetailRow('Phone', '+254 708 696 969'),
          _buildDetailRow('Bio', 'This is a short bio about Me.'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title, style: const TextStyle(fontSize: 18)),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          Get.to(() => const LoginScreen());
        },
        child: const Text('Logout'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15), backgroundColor: Colors.deepOrange,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), 
        ),
      ),
    );
  }
}

class ProfilePostsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PostsScreen(), 
    );
  }
}

class ProfileSettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: UniqueSettingsScreen(), 
    );
  }
}