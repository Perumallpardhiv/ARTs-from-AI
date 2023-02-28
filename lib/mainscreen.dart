import 'dart:io';
import 'dart:typed_data';

import 'package:ai_art/aoifetch.dart';
import 'package:ai_art/my_arts.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({super.key});

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  var sizes = ["Small", "Medium", "Large"];
  var values = ['256x256', '512x512', '1024x1024'];
  String? dropValue;
  TextEditingController controller = TextEditingController();
  String img = '';
  var isLoading = true;
  var p = 0;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              icon: Icon(Icons.photo_album),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.brown[600],
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => myArts()));
              },
              label: Text("My Arts"),
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.brown,
        title: Text(
          "AI - Image Generator",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(13),
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      height: 46,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.brown[50],
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: TextFormField(
                        controller: controller,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: "eg: A lion on Elephant",
                          hintStyle: TextStyle(fontSize: 16),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 46,
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.brown[50],
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        icon: Icon(Icons.expand_more),
                        value: dropValue,
                        hint: Text(
                          "Select Size",
                          style: TextStyle(fontSize: 10),
                        ),
                        items: List.generate(
                          sizes.length,
                          (index) => DropdownMenuItem(
                            value: values[index],
                            child: Text(
                              sizes[index],
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            dropValue = value.toString();
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    height: 40,
                    width: 35,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.text.isNotEmpty &&
                            dropValue!.isNotEmpty) {
                          setState(() {
                            isLoading = true;
                            p = 1;
                          });
                          var urllink = await apiFetch.generateImage(
                            controller.text,
                            dropValue!,
                          );
                          setState(() {
                            isLoading = false;
                            img = urllink;
                            p = 1;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please enter some Text"),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.brown[700],
                      ),
                      child: Icon(
                        Icons.send,
                        size: 19,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: !isLoading && p == 1
                  ? Container(
                      margin: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.brown,
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.brown[400],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Screenshot(
                              controller: screenshotController,
                              child: Image.network(
                                img,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : p == 1
                      ? Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.brown[400],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Lottie.asset('assets/Loading.json'),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                  "Image is Loading",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Colors.brown[900],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.brown[400],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Lottie.asset('assets/Paperplane.json'),
                              ),
                              Center(
                                child: Text(
                                  "Type Something in above fields",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Colors.brown[900],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.download),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Colors.brown[600],
                          ),
                          onPressed: () async {
                            var result = await Permission.storage.request();
                            var result1 =
                                await Permission.accessMediaLocation.request();
                            var result2 = await Permission.manageExternalStorage
                                .request();

                            if (result.isGranted &&
                                result1.isGranted &&
                                result2.isGranted) {
                              final foldername = "AI Image";
                              final path = await Directory(
                                "storage/emulated/0/$foldername",
                              );

                              if (await path.exists()) {
                                print(path.path);
                              } else {
                                await Directory(
                                  "storage/emulated/0/$foldername",
                                ).create(recursive: true);
                              }

                              await screenshotController.captureAndSave(
                                path.path,
                                delay: Duration(milliseconds: 100),
                                fileName:
                                    "${DateTime.now().millisecondsSinceEpoch}.png",
                                // pixelRatio: 1.0,
                              );
                              print(DateTime.now().millisecondsSinceEpoch);

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Downloded to ${path.path}"),
                              ));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Permission is denied")));
                            }
                          },
                          label: Text("Download"),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton.icon(
                        icon: Icon(Icons.share),
                        style: ElevatedButton.styleFrom(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.brown[600],
                        ),
                        onPressed: () async {
                          await screenshotController
                              .capture(
                                  pixelRatio: 1.0,
                                  delay: Duration(milliseconds: 100))
                              .then(
                            (Uint8List? img) async {
                              if (img != null) {
                                final directory =
                                    (await getApplicationDocumentsDirectory())
                                        .path;
                                final filename = "share.png";
                                final imgpath =
                                    await File("${directory}/${filename}")
                                        .create();
                                await imgpath.writeAsBytes(img);

                                Share.shareFiles([imgpath.path],
                                    text: "Generated by AI");
                              } else {
                                print("Failed to take screenshot");
                              }
                            },
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Image Shared")));
                        },
                        label: Text("Share"),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
