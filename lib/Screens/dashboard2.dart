import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_discharge/Screens/Home_Screen/home.dart';
import 'package:post_discharge/Screens/order.dart';
import 'package:post_discharge/Screens/planner.dart';
import 'package:post_discharge/Screens/profile/profile.dart';
import 'package:post_discharge/controllers/dasboardcontroller.dart';

const List<BottomNavigationBarItem> myMenus=[
  BottomNavigationBarItem(icon:Icon(Icons.home),label: "Home" ),
  BottomNavigationBarItem(icon: Icon(Icons.show_chart),label: "Activity"),
  BottomNavigationBarItem(icon: Icon(Icons.local_hospital),label: "Health Planner"),
  BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
];
List myScreens=[
  const Dashboard(),
  DoctorScreen(),
  FancyPlannerScreen(patientName: 'Alex',),
  MyProfileScreen()
];
DashboardController dashboardController=Get.put(DashboardController());
class PatientDashboard extends StatelessWidget {
  const PatientDashboard({super.key});
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      body:Obx(()=> myScreens[dashboardController.selectedMenu.value],),

      bottomNavigationBar:Obx(()=> BottomNavigationBar(items:myMenus,
      selectedItemColor:Colors.blueAccent,
      selectedLabelStyle: const TextStyle(color: Colors.blueAccent),
      unselectedItemColor: Colors.black45, 
      unselectedLabelStyle: const TextStyle(color: Colors.black45),
      showUnselectedLabels: true,
      onTap: (val) =>dashboardController.UpdateSelectedMenu(val),
      currentIndex: dashboardController.selectedMenu.value,
      backgroundColor: Theme.of(context).primaryColor,

      
      ),
      )
      
    );
  }
} 