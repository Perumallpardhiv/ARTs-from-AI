import 'dart:io';

import 'package:ai_art/image_generator/viewImg.dart';
import 'package:flutter/material.dart';

class myArts extends StatefulWidget {
  const myArts({super.key});

  @override
  State<myArts> createState() => _myArtsState();
}

class _myArtsState extends State<myArts> {
  List imgsList = [];

  getImages() {
    final direc = Directory("storage/emulated/0/AI Image");
    setState(() {
      imgsList = direc.listSync();
    });
    print(imgsList);
    return null;
  }

  @override
  void initState() {
    super.initState();
    getImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade400,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.brown.shade400,
        title: Text(
          "AI IMAGES",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => getImages(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemCount: imgsList.length,
            itemBuilder: (context, index) {
              return Hero(
                tag: imgsList[index],
                child: GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => viewImage(imgsList[index]),
                      ),
                    );
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.file(imgsList[index], fit: BoxFit.cover),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
