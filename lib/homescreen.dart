import 'dart:math';

import 'package:ai_art/mainscreen.dart';
import 'package:ai_art/pulseAnimator.dart';
import 'package:flutter/material.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.brown[400],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.brown.shade400,
                  BlendMode.hue,
                ),
                child: pulseAnimator(
                  child: Container(
                    height: size.height * 0.35,
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.brown.shade800,
                        width: 6,
                      ),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/robot.png'),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: RawMaterialButton(
                  elevation: 4,
                  fillColor: Colors.brown.shade500,
                  splashColor: Colors.brown.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => mainScreen(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform(
                          transform: Matrix4.rotationY(pi),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.imagesearch_roller_outlined,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        SizedBox(width: 10),
                        pulseAnimator(
                          child: Text(
                            "AI IMAGE GENERATOR",
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: RawMaterialButton(
                  elevation: 4,
                  fillColor: Colors.brown.shade500,
                  splashColor: Colors.brown.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  onPressed: () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform(
                          transform: Matrix4.rotationY(pi),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.image_outlined,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        SizedBox(width: 10),
                        pulseAnimator(
                          child: Text(
                            "IMAGE BACKGROUND REMOVE",
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
