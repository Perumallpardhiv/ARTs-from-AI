import 'dart:math';
import 'package:ai_art/bg_removal/bgremoval.dart';
import 'package:ai_art/image_generator/mainscreen.dart';
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
    return Scaffold(
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
                    image: const DecorationImage(
                      image: AssetImage('assets/robot.png'),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: RawMaterialButton(
                elevation: 4,
                fillColor: Colors.brown.shade500,
                splashColor: Colors.brown.shade300,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const mainScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Transform(
                        transform: Matrix4.rotationY(pi),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.imagesearch_roller_outlined,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const pulseAnimator(
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
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const bgRemoval(),
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Transform(
                        transform: Matrix4.rotationY(pi),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.image_outlined,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const pulseAnimator(
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
    );
  }
}
