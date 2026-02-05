import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/pages/home/homePage.dart';
import 'package:pickup_load_update/src/pages/profile/profilePage.dart';

import '../../pages/Trip History/all trip/quick_tech_all_trip_history.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedItemPosition = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        extendBody: true,
        body: AnimatedContainer(
          child: _getPage(_selectedItemPosition),
          duration: const Duration(seconds: 1),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: primaryColor,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white,
          currentIndex: _selectedItemPosition,
          onTap: (index) => setState(() => _selectedItemPosition = index),
          items:  [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'home'.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'tripHistory'.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'profile'.tr,
            ),
          ],
          selectedLabelStyle: const TextStyle(fontSize: 14),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit the customer app?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes'),
          ),
        ],
      ),
    ).then((value) => value ?? false);
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return QuickTechAllTripScreen();
      case 2:
        return ProfilePage();
      default:
        return HomePage();
    }
  }
}
