import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTextFieldController = TextEditingController();
  String textSearch = "";
//---------

  String videoTitle = "";
  String videoAuther = "";
  String videoId = "";
  bool progressHiden = false;
  double progressVal = 0.0;
//-------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 66, 240, 210),
                    Color.fromARGB(255, 253, 244, 193),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: ListView(
                  children: [
                    Container(
                      height: 60,
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          textSearch = value;
                          getVideoInfo(searchTextFieldController.text);
                        },
                        controller: searchTextFieldController,
                        decoration: InputDecoration(
                          suffix: IconButton(
                            icon: const Icon(
                              Icons.close,
                            ),
                            onPressed: () {
                              setState(() {
                                searchTextFieldController.clear();
                              });
                            },
                          ),
                          label: Text("Search"),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(style: BorderStyle.solid)),
                          disabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(style: BorderStyle.solid)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide()),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(style: BorderStyle.solid)),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 46, 220, 182),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 160,
                                width: MediaQuery.of(context).size.width / 3,
                                child: Image.network(
                                  "https://img.youtube.com/vi/$videoId/0.jpg",
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container();
                                  },
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      videoTitle,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(255, 47, 175, 255),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      videoAuther,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color:
                                            Color.fromARGB(255, 42, 163, 239),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    progressHiden
                        ? LinearProgressIndicator(
                            backgroundColor: Colors.blue,
                            value: progressVal,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.pink))
                        : Container(),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 204, 39, 102),
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: MaterialButton(
                        child: const Text(
                          "Start Download",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        onPressed: () {
                          print("ssss");
                          if (textSearch == "") {
                            Get.snackbar(
                              "error",
                              "Plz Enter The URL",
                              colorText: Colors.white,
                            );
                          } else {
                            print("aaaa111");
                            download(searchTextFieldController.text);
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getVideoInfo(String url) async {
    var youtubeInfo = YoutubeExplode();
    var video = await youtubeInfo.videos.get(url);
    setState(() {
      videoTitle = video.title;
      videoAuther = video.author;
      videoId = video.id.toString();
    });
  }

  Future<void> download(String url) async {
    var permission = await Permission.storage.request();
    print(permission.isGranted);
    print("......................");
    if (permission.isGranted) {
      setState(() {
        print("bahaa");
        progressHiden = true;
        progressVal = 0.0;
      });

      var youtube = YoutubeExplode();
      var video = await youtube.videos.get(url);
      var manifest = await youtube.videos.streamsClient.getManifest(url);
      var streams = manifest.muxed.withHighestBitrate();
      var audio = streams;
      var audioStream = youtube.videos.streamsClient.get(audio);
      //
      Directory? appDocDir = await getExternalStorageDirectory();
      String appDocPath = '${appDocDir!.path}/myDir';
      var file = File('$appDocPath/${video.id}.mp4');
      print(video.id);
      await new Directory(appDocPath).create();

      if (file.existsSync()) {
        file.deleteSync();
      }

      var output = file.openWrite(mode: FileMode.writeOnlyAppend);
      var size = audio.size.totalBytes;
      var count = 0;
      await for (final data in audioStream) {
        count += data.length;
        double val = (count / size);
        setState(() {
          progressVal = val;
        });

        output.add(data);
      }
      Get.snackbar(video.title, "Done!!! With Bahaa^__^",
          colorText: Colors.green);
    } else {
      await Permission.storage.request();
    }
  }
}
