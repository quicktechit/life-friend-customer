// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:pickup_load_update/src/configs/appColors.dart';
// import 'package:pickup_load_update/src/pages/Trip%20History/trip_history_page.dart';
// import 'package:pickup_load_update/src/pages/home/homePage.dart';
// import 'package:pickup_load_update/src/pages/profile/profilePage.dart';
//
// void main() => runApp(const BottomNavigationBarExampleApp());
//
// class BottomNavigationBarExampleApp extends StatelessWidget {
//   const BottomNavigationBarExampleApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: BottomNavigationBarExample(),
//     );
//   }
// }
//
// class BottomNavigationBarExample extends StatefulWidget {
//   const BottomNavigationBarExample({super.key});
//
//   @override
//   State<BottomNavigationBarExample> createState() =>
//       _BottomNavigationBarExampleState();
// }
//
// class _BottomNavigationBarExampleState
//     extends State<BottomNavigationBarExample> {
//   int _selectedIndex = 0;
//   static const TextStyle optionStyle =
//       TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//   static List<Widget> _widgetOptions = <Widget>[
//     HomePage(),
//     AllTripHistoryPage(),
//     ProfilePage()
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   _getOutOFApp() {
//     if (Platform.isIOS) {
//       try {
//         exit(0);
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       try {
//         SystemNavigator.pop();
//       } catch (e) {
//         print(e);
//       }
//     }
//   }
//
//   exiDialogue(context) {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return Dialog(
//             child: Container(
//               height: 150,
//               width: 310,
//               decoration:
//                   BoxDecoration(borderRadius: BorderRadius.circular(20)),
//               child: Padding(
//                 padding: EdgeInsets.only(left: 25, top: 18, bottom: 18),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Are you sure to exits from Customer App?',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//                     ),
//                     Row(
//                       children: [
//                         ElevatedButton(
//                             style: ButtonStyle(
//                               backgroundColor: MaterialStateProperty.all(
//                                 Color(0xFF006A4E),
//                               ),
//                             ),
//                             onPressed: () => _getOutOFApp(),
//                             child: Text(
//                               'Yes',
//                               style: TextStyle(
//                                   color: Colors.red,
//                                   fontWeight: FontWeight.bold),
//                             )),
//                         VerticalDivider(),
//                         ElevatedButton(
//                             style: ButtonStyle(
//                               backgroundColor: MaterialStateProperty.all(
//                                 Color(0xFF006A4E),
//                               ),
//                             ),
//                             onPressed: () => Navigator.pop(context),
//                             child: Text('No',
//                                 style: TextStyle(color: Colors.black))),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () {
//         exiDialogue(context);
//         return Future.value(false);
//       },
//       child: Scaffold(
//         body: Center(
//           child: _widgetOptions.elementAt(_selectedIndex),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           backgroundColor: Colors.black,
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.car_crash),
//               label: 'Trip History',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               label: 'Profile',
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           selectedItemColor: bgColor,
//           unselectedItemColor: Colors.grey,
//           onTap: _onItemTapped,
//         ),
//       ),
//     );
//   }
// }
