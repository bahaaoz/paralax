import 'dart:io' as io;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_down/Screens/home-screen.dart';
import 'package:youtube_down/Screens/search_screen.dart';

List files = [];
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  //await readVideos();
  runApp(const MyApp());
}

// Future<void> readVideos() async {
//   Directory? appDocDir = await getExternalStorageDirectory();
//   String appDocPath = '${appDocDir!.path}/myDir';

//   files = io.Directory("$appDocPath").listSync();
//   print(files[0]);
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            // bottomNavigationBar: BottomNavigationBar(
            //   currentIndex: currentIndex,
            //   onTap: (value) {
            //     setState(() {
            //       currentIndex = value;
            //     });
            //   },
            //   items: const <BottomNavigationBarItem>[
            //     BottomNavigationBarItem(
            //         icon: Icon(Icons.home),
            //         label: "Home",
            //         backgroundColor: Colors.green),
            //     BottomNavigationBarItem(
            //         label: "Search",
            //         icon: Icon(Icons.search),
            //         backgroundColor: Colors.yellow),
            //     BottomNavigationBarItem(
            //       label: "Profile",
            //       icon: Icon(Icons.person),
            //       backgroundColor: Colors.blue,
            //     ),
            //   ],
            // ),
            body: HomeScreen()));
  }
}
