import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class viewImage extends StatefulWidget {
  var img;
  viewImage(this.img, {super.key});

  @override
  State<viewImage> createState() => _viewImageState();
}

class _viewImageState extends State<viewImage> {
  ScreenshotController screenshotController = ScreenshotController();

  Future<void> deleteFile(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
        print("deleted");
      }
    } catch (e) {
      print(e);
    }
  }

  shareFile() async {
    final ssImage = await screenshotController.capture();
    final directory = await getApplicationDocumentsDirectory();
    final imgPath = await File('${directory.path}/image.png').create();
    imgPath.writeAsBytesSync(ssImage!);
    final text = 'AI Generated Image';
    await Share.shareFiles([imgPath.path], text: text);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Image Shared"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[400],
      body: Stack(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.antiAlias,
              height: 300,
              width: 300,
              child: Hero(
                tag: widget.img,
                child: Screenshot(
                  controller: screenshotController,
                  child: Image.file(widget.img, fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, right: 17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      shareFile();
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      deleteFile(widget.img);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
