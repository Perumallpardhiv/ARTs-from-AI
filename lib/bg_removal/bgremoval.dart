import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:ai_art/bg_removal/api.dart';
import 'package:before_after/before_after.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class bgRemoval extends StatefulWidget {
  const bgRemoval({super.key});

  @override
  State<bgRemoval> createState() => _bgRemovalState();
}

class _bgRemovalState extends State<bgRemoval> {
  bool pickedImage = false;
  bool removedbg = false;
  String imagePath = '';
  Uint8List? image;
  bool isLoading = false;
  ScreenshotController screenshotController = ScreenshotController();

  Future<void> pickImage() async {
    final img = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );

    if (img != null) {
      imagePath = img.path;
      pickedImage = true;
      setState(() {});
    } else {}
  }

  downloadImage() async {
    var result = await Permission.storage.request();
    var result1 = await Permission.accessMediaLocation.request();
    var result2 = await Permission.manageExternalStorage.request();

    var foldername = "BG Remover";
    var fileName = "${DateTime.now().millisecondsSinceEpoch}.png";

    if (result.isGranted && result1.isGranted && result2.isGranted) {
      final directory = Directory("storage/emulated/0/$foldername");

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      await screenshotController.captureAndSave(
        directory.path,
        delay: const Duration(milliseconds: 100),
        fileName: fileName,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Downloded to ${directory.path}"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Permission is denied"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        leading: (removedbg || pickedImage)
            ? IconButton(
                icon: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(pi)..rotateZ(7 * pi/4),
                  child: const Icon(Icons.replay_rounded),
                ),
                onPressed: () {
                  pickedImage = false;
                  removedbg = false;
                  imagePath = '';
                  image;
                  isLoading = false;
                  setState(() {});
                },
              )
            : const Icon(Icons.sort_outlined),
        backgroundColor: Colors.brown,
        centerTitle: true,
        title: const Text(
          "AI Background Removal",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        actions: [
          if (removedbg)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                downloadImage();
              },
            ),
        ],
      ),
      body: Center(
        child: removedbg
            ? BeforeAfter(
                afterImage: Screenshot(
                  controller: screenshotController,
                  child: Image.memory(image!),
                ),
                beforeImage: Image.file(File(imagePath)),
              )
            : pickedImage
                ? GestureDetector(
                    onTap: () {
                      pickImage();
                    },
                    child: Image.file(
                      File(imagePath),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(45),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      border: Border.all(color: Colors.black),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown[700]),
                      onPressed: () {
                        pickImage();
                      },
                      child: const Text("Pick Image"),
                    ),
                  ),
      ),
      bottomNavigationBar: SizedBox(
        height: 55,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.brown[700]),
          onPressed: pickedImage
              ? () async {
                  isLoading = true;
                  setState(() {});
                  image = await Api.removebg(imagePath);
                  isLoading = false;
                  if (image != null) {
                    removedbg = true;
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text("Background can't removed for this picture"),
                      ),
                    );
                  }
                  setState(() {});
                }
              : null,
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : const Text("Removal Background"),
        ),
      ),
    );
  }
}
