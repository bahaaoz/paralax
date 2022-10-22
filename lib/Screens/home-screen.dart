import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_down/Screens/search_screen.dart';
import 'package:youtube_down/main.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController? _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("hello");
    _scrollController = ScrollController()
      ..addListener(() {
        print("wow");
        onListener();
      });
  }

  double _screenOffset = 0.0;
  onListener() {
    setState(() {
      _screenOffset = _scrollController!.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height * 2.5;
    double _screenWidth = MediaQuery.of(context).size.width;

    double _layer1Speed = 0.6;
    double _layer2Speed = 0.55;
    double _layer3Speed = 0.5;
    double _layer4Speed = 0.4;
    double _textSpeed = 0.032;

    double _rightSpeed = 0.15;
    double _leftSpeed = 0.15;

    return Scaffold(
      body: Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 66, 240, 210),
            Color.fromARGB(255, 253, 244, 193),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Stack(
          children: [
            Positioned(
              right: 200,
              left: _screenOffset / 7,
              bottom: (MediaQuery.of(context).size.height / 2) +
                  _screenOffset * 0.2,
              child: Image.asset(
                'images/sun.png',
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: _layer4Speed * _screenOffset,
              child: Image.asset(
                'images/mountains-layer-4.png',
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: _layer3Speed * _screenOffset,
              child: Image.asset(
                'images/mountains-layer-3.png',
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: _layer2Speed * _screenOffset,
              child: Image.asset(
                'images/trees-layer-2.png',
              ),
            ),
            Positioned(
              right: _rightSpeed * _screenOffset * -1,
              left: _leftSpeed * _screenOffset * -1,
              bottom: -20 + _layer1Speed * _screenOffset,
              child: Image.asset(
                'images/layer-1.png',
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height -
                    40 -
                    _layer1Speed * _screenOffset,
                right: 0,
                left: 0,
                child: Container(
                  height: _screenHeight,
                  color: Colors.black,
                )),
            Positioned.fill(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: SizedBox(
                  height: _screenHeight,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: MediaQuery.of(context).size.height -
                  _layer1Speed * _screenOffset,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "Hello!! im Bahaa",
                      style: TextStyle(
                        fontSize: _textSpeed * _screenOffset,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(),
                        IconButton(
                          color: const Color.fromARGB(255, 66, 240, 210),
                          iconSize: 50,
                          onPressed: () {
                            print("object");
                          },
                          icon: const Icon(
                            Icons.home,
                          ),
                        ),
                        IconButton(
                          iconSize: 50,
                          color: const Color.fromARGB(255, 66, 240, 210),
                          onPressed: () {
                            Get.to(SearchScreen());
                          },
                          icon: const Icon(
                            Icons.search,
                          ),
                        ),
                        IconButton(
                          iconSize: 50,
                          color: const Color.fromARGB(255, 66, 240, 210),
                          onPressed: () {},
                          icon: const Icon(
                            Icons.person,
                          ),
                        ),
                        Container()
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
