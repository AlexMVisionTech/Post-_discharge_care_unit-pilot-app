import 'package:get/get.dart';

class DashboardController extends GetxController{
  var selectedMenu=0.obs;
  UpdateSelectedMenu(pos)=>selectedMenu.value=pos;
}