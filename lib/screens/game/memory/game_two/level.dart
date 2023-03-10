import 'package:brain_application/screens/game/memory/Memory_Screen.dart';
import 'package:flutter/material.dart';

import 'memory_two_screen.dart';

class LevelScreen extends StatefulWidget {
  const LevelScreen({super.key});

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  String _dataLevel1 = "Easy";
  String _dataLevel2 = "Medium";
  String _dataLevel3 = "Difficult";

  checkButton(String data, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MemoryTwoScreen(
              levelValue: data,
            ),
          ),
        );
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xff387ee8).withOpacity(0.4),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(3, 3),
              blurRadius: 3,
              color: Colors.white.withOpacity(0.3),
            ),
          ],
          border: Border.all(
            color: Colors.white,
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0x00000000),
        body: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                const Color(0xff0846a3),
                const Color(0xff387ee8),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon back
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      print("Back Here");
                      Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MemoryScreen()));
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    iconSize: 30,
                  ),
                ],
              ),
              const Text(
                "Độ Khó",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 35,
                ),
              ),
              Container(
                // color: Colors.amber,
                child: Image.asset(
                  "assets/memory_two.png",
                  height: screen_height / 3,
                  width: screen_width,
                ),
              ),
              SizedBox(
                height: screen_height / 30,
              ),
              Expanded(
                child: Center(
                  child: Container(
                    // color: Colors.brown,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Dễ
                        checkButton(_dataLevel1, "Dễ"),
                        SizedBox(
                          height: screen_height / 30,
                        ),
                        // Trung Bình
                        checkButton(_dataLevel2, "Trung Bình"),
                        SizedBox(
                          height: screen_height / 30,
                        ),
                        // Khó
                        checkButton(_dataLevel3, "Khó"),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
