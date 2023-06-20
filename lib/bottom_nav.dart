// import 'package:flutter/material.dart';
// import 'package:sampleapp/landing_page.dart';
// import 'package:sampleapp/recent_page.dart';

// const List<String> paths = [
//   'assets/images1.jpg',
//   'assets/img.jpg',
//   'assets/images1.jpg',
//   'assets/img.jpg',
//   'assets/img.jpg',
//   'assets/images1.jpg',
//   'assets/img.jpg',
//   'assets/img.jpg',
//   'assets/img.jpg',
//   'assets/img.jpg',
//   'assets/img.jpg'
// ];

// class MyNavigationBar extends StatefulWidget {
//   const MyNavigationBar({super.key});

//   @override
//   _MyNavigationBarState createState() => _MyNavigationBarState();
// }

// class _MyNavigationBarState extends State<MyNavigationBar> {
//   int _selectedIndex = 0;
//   static const List<Widget> _widgetOptions = <Widget>[
//     Landing(),
//     RecentPage(paths),
//     Text('Profile Page',
//         style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.red,
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.camera),
//                 label: 'Camera',
//                 // activeIcon: Icon(Icons.camera,color: Colors.amber,),
//                 backgroundColor: Color.fromRGBO(1, 155, 113, 1)
//                 ),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.grid_view_rounded),
//                 label: 'images',
//                 backgroundColor: Color.fromRGBO(1, 0, 113, 1)
//                 ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.settings),
//               label: 'Profile',
//               backgroundColor: Color.fromRGBO(1, 155, 0, 1),
//             ),
//           ],
//           type: BottomNavigationBarType.shifting,
//           currentIndex: _selectedIndex,
//           selectedItemColor: Colors.black38,
//           iconSize: 40,
//           onTap: _onItemTapped,
//           elevation: 5),
//     );
//   }
// }
