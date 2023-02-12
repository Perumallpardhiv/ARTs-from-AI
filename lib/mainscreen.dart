import 'package:ai_art/aoifetch.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
              onPressed: () {},
              label: Text("My Arts"),
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.brown,
        title: Text(
          "AI the Image Generator",
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
                            child: Image.network(
                              img,
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
                          onPressed: () {},
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
                        onPressed: () {},
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
