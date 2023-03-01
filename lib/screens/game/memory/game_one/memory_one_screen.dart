import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:brain_application/data/data_memory/data_memory_one.dart';
import 'package:brain_application/screens/game/memory/test_screen.dart';
import 'package:brain_application/widgets/components/score_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameOne extends StatefulWidget {
  const GameOne({super.key});

  @override
  State<GameOne> createState() => _GameOneState();
}

class _GameOneState extends State<GameOne> {
  int numOfRow = 0; // Số card trên 1 hàng
  int highlight = 0;
  bool _showOverlay = false;
  bool _showSuccess = false;
  bool _showFail = false;
  bool _disableTap = false;
  bool _isLoading = false;
  Timer? _timer1; // Thời gian 4s để hiện đếm ngược
  Timer? _timer2; // Thời gian 3s để highlight
  Timer? _timerSucess;
  Timer? _timerLevel;
  // bool _isDispose = false;

  // Setup number of highlight of each level
  cardOfLevel(numOfB, numOfW) {
    pairsBlue = getBlue();
    pairsWhite = getWhite();
    total = numOfB + numOfW;
    pairs = pickRandomItemsAsListWithSubList(pairsBlue, numOfB) +
        pickRandomItemsAsListWithSubList(pairsWhite, numOfW);
    visiblePairs = pickRandomItemsAsListWithSubList(pairsWhite, total);
    selected = true;
    _showOverlay = true;

    _timer1 = Timer(Duration(seconds: 4), () {
      setState(() {
        pairs.shuffle();
        visiblePairs = pairs;
        selected = true;
        _showOverlay = false;
      });
    });
    _timer2 = Timer(Duration(seconds: 6), () {
      setState(() {
        selected = false;
        visiblePairs = pickRandomItemsAsListWithSubList(pairsWhite, total);
        startTimer();
      });
    });
  }

// Hiển thị những ô đúng còn lại (chưa chọn) khi end game
  showResult() {
    result = getResult();
    for (int i = 0; i < indexResult.length; i++) {
      pairs[indexResult[i]] = result[0];
    }
    setState(() {
      visiblePairs = pairs;
    });
  }

// Animation of Success
  showSuccess() async {
    _showSuccess = true;
    setState(() {
      _disableTap = true;
    });
    // await Future.delayed(Duration(seconds: 3), () {
    //   setState(() {
    //     _showSuccess = false;
    //   });
    // });
    // Hiện icon success trong vòng 3s
    _timerSucess = Timer(Duration(seconds: 3), () {
      setState(() {
        _showSuccess = false;
      });
    });
  }

  // Animation of Wrong
  showFail() {
    _showFail = true;
    _disableTap = true;
    // Future.delayed(Duration(seconds: 3), () {
    //   setState(() {
    //     _showFail = false;
    //   });
    // });
    _timerSucess = Timer(Duration(seconds: 3), () {
      setState(() {
        _showFail = false;
      });
    });
  }

  initLevel() {
    if (maxLevel <= 1) {
      level = 1;
    } else {
      level = maxLevel ~/ 2;
    }
  }

  displayLevel() {
    // initLevel();
    if (level == 1) {
      // 2x3
      cardOfLevel(1, 5);
      numOfRow = 3;
      highlight = level;
      error = 1;
      timeLeft = 10;
    } else if (level == 2) {
      // 3x3
      cardOfLevel(2, 7);
      numOfRow = 3;
      highlight = level;
      error = 1;
      timeLeft = 10;
    } else if (level == 3) {
      // 3x4
      cardOfLevel(3, 9);
      numOfRow = 4;
      highlight = level;
      error = 1;
      timeLeft = 10;
    } else if (level == 4) {
      // 4x4
      cardOfLevel(4, 12);
      numOfRow = 4;
      highlight = level;
      error = 1;
      timeLeft = 10;
    } else if (level == 5) {
      // 4x5
      cardOfLevel(5, 15);
      numOfRow = 4;
      highlight = level;
      error = 2;
      timeLeft = 10;
    } else if (level == 6) {
      // 4x5
      cardOfLevel(6, 14);
      numOfRow = 4;
      highlight = level;
      error = 2;
      timeLeft = 15;
    } else if (level == 7) {
      // 5x5
      cardOfLevel(7, 18);
      numOfRow = 5;
      highlight = level;
      error = 3;
      timeLeft = 20;
    } else if (level == 8) {
      // 5x6
      cardOfLevel(8, 22);
      numOfRow = 5;
      highlight = level;
      error = 3;
      timeLeft = 20;
    } else if (level == 9) {
      // 5x6
      cardOfLevel(9, 21);
      numOfRow = 5;
      highlight = level;
      error = 4;
      timeLeft = 20;
    } else if (level == 10) {
      // 6x6
      cardOfLevel(10, 26);
      numOfRow = 6;
      error = 4;
      highlight = level;
      timeLeft = 25;
    } else if (level == 11) {
      // 6x7
      cardOfLevel(11, 31);
      numOfRow = 6;
      error = 4;
      highlight = level;
      timeLeft = 25;
    } else if (level == 12) {
      // 6x7
      cardOfLevel(12, 30);
      numOfRow = 6;
      error = 4;
      highlight = level;
      timeLeft = 30;
    } else if (level == 13) {
      // 7x7
      cardOfLevel(13, 36);
      numOfRow = 7;
      error = 4;
      highlight = level;
      timeLeft = 30;
    } else if (level == 14) {
      // 7x7
      cardOfLevel(14, 35);
      numOfRow = 7;
      error = 4;
      highlight = level;
      timeLeft = 30;
    } else if (level == 15) {
      // 7x8
      cardOfLevel(15, 41);
      numOfRow = 7;
      error = 4;
      highlight = level;
      timeLeft = 35;
    } else if (level == 16) {
      // 7x8
      cardOfLevel(16, 40);
      numOfRow = 7;
      highlight = level;
      error = 4;
      timeLeft = 35;
    } else if (level == 17) {
      // 8x8
      cardOfLevel(17, 47);
      numOfRow = 8;
      highlight = level;
      error = 4;
      timeLeft = 40;
    } else if (level == 18) {
      // 8x8
      cardOfLevel(18, 46);
      numOfRow = 8;
      error = 4;
      highlight = level;
      timeLeft = 40;
    } else if (level == 19) {
      // 8x8
      cardOfLevel(19, 45);
      numOfRow = 8;
      highlight = level;
      error = 4;
      timeLeft = 40;
    } else if (level == 20) {
      // 8x9
      cardOfLevel(20, 52);
      numOfRow = 8;
      highlight = level;
      error = 5;
      timeLeft = 45;
    } else if (level == 21) {
      // 8x9
      cardOfLevel(21, 51);
      numOfRow = 8;
      highlight = level;
      error = 5;
      timeLeft = 45;
    } else if (level == 22) {
      // 9x9
      cardOfLevel(22, 59);
      numOfRow = 9;
      highlight = level;
      error = 5;
      timeLeft = 50;
    } else if (level == 23) {
      // 9x9
      cardOfLevel(23, 58);
      numOfRow = 9;
      highlight = level;
      error = 5;
      timeLeft = 50;
    } else if (level == 24) {
      // 9x9
      cardOfLevel(24, 57);
      numOfRow = 9;
      highlight = level;
      error = 5;
      timeLeft = 50;
    } else if (level == 25) {
      // 9x10
      cardOfLevel(25, 65);
      numOfRow = 9;
      highlight = level;
      error = 5;
      timeLeft = 55;
    } else if (level == 26) {
      // 9x10
      cardOfLevel(26, 64);
      numOfRow = 9;
      highlight = level;
      error = 5;
      timeLeft = 55;
    } else if (level == 27) {
      // 9x10
      cardOfLevel(27, 63);
      numOfRow = 9;
      highlight = level;
      error = 5;
      timeLeft = 60;
    } else if (level == 28) {
      // 10x10
      cardOfLevel(28, 72);
      numOfRow = 10;
      highlight = level;
      error = 5;
      timeLeft = 60;
    } else if (level == 29) {
      // 10x10
      cardOfLevel(29, 71);
      numOfRow = 10;
      highlight = level;
      error = 5;
      timeLeft = 60;
    } else if (level == 30) {
      // 10x10
      cardOfLevel(30, 70);
      numOfRow = 10;
      error = 5;
      highlight = level;
      timeLeft = 60;
    }
  }

// Time 1: Thời gian 3s để chuẩn bị
  int percent = 3;
  Timer? timer;
  displayTimer() {
    timer = Timer.periodic(Duration(milliseconds: 1000), (_) {
      setState(() {
        percent -= 1;
        if (percent <= 0) {
          print("3s countdown end");
          timer?.cancel();
        }
      });
    });
  }

  // Time 2: Thời gian để chơi mỗi level
  Timer? _timerGoResult;
  Timer? _timer;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (timer) => setState(() {
        if (timeLeft <= 0) {
          timer.cancel();

          if ((numOfWrong == 0 || numOfWrong > 0) && tries < 5) {
            _disableTap = true;
            print("Time out");
            screenLevelDown();

            indexResult = [];

            // Future.delayed(Duration(seconds: 4), () {
            //   setState(() {
            //     levelDown();
            //   });
            // });
            _timerLevel = Timer(Duration(seconds: 4), () {
              setState(() {
                levelDown();
              });
            });
          } else if (tries >= 5) {
            _disableTap = true;
            screenLevelDown();
            print("Final time out");
            if (maxLevel < level) {
              maxLevel = level;
            }
            // Future.delayed(Duration(seconds: 4), () {
            //   setState(() {
            //     navigationPage();
            //   });
            // });
            _timerGoResult = Timer(Duration(seconds: 4), () {
              setState(() {
                // navigationPage();
              });
            });
          }
        } else {
          timeLeft = timeLeft - 1;
        }
      }),
    );
  }

  // Hàm dừng thời gian
  void stopTimer() {
    _timer?.cancel();
  }

  // Level up
  void levelUp() {
    level++;
    tries++;

    // start();
    // isStart();
    isLoading();
  }

  // Level down
  void levelDown() {
    level -= numOfWrong ~/ 2;
    tries++;
    // start();
    // isStart();
    isLoading();
  }

  // Hàm show result and then showFail after 1s
  Timer? _timer3;
  screenLevelDown() async {
    await showResult();
    // Future.delayed(Duration(seconds: 1), () async {
    //   setState(() {
    //     showFail();
    //   });
    // });
    _timer3 = Timer(Duration(seconds: 1), () {
      setState(() {
        showFail();
      });
    });
  }

  void disableTap() {
    selected = true;
    Future.delayed(Duration(microseconds: 100), () {
      selected = false;
    });
  }

  // màn hình hiển thị level
  screenLoadingLevel() {
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Cấp Độ $level",
          style: const TextStyle(
            fontFamily: 'Inter',
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const SpinKitSquareCircle(
          color: Color(0xff0081c9),
          size: 100,
          duration: Duration(seconds: 1),
        ),
      ],
    );
  }

  // Hàm chức năng hiện thị level
  late Timer _timerLoading;
  isLoading() async {
    _isLoading = true;
    _timerLoading = Timer(Duration(seconds: 2), () {
      setState(() {
        displayLevel();
        _isLoading = false;
        start();
      });
    });
  }

  // Navigation to Result page
  // navigationPage() {
  //   setState(() {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => ResultPage()),
  //     );
  //   });
  // }

  start() {
    _disableTap = false;
    numOfCorrect = 0;
    numOfWrong = 0;
    store = [];
    percent = 3;
    level;
    displayTimer();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tries = 1;
    score = 0;
    // start();
    // isStart();
    initLevel();
    maxLevel = level;
    isLoading();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timerLoading.cancel();
    // _isDispose = true;
    timer?.cancel();
    _timer1?.cancel();
    _timer2?.cancel();
    _timer?.cancel();
    _timerSucess?.cancel();
    _timerLevel?.cancel();
    _timer3?.cancel();
    // _timer4.cancel();
    _timerGoResult?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffe5f6fe),
        body: Container(
          width: screen_width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icons
              Row(
                // crossAxisAlignment: CrossAxisAlignment.spaceBetween,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Row(
                  //   children: [
                  //     IconButton(
                  //       onPressed: () {
                  //         print("Back Here");
                  //         Navigator.pop(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => HomePage()));
                  //       },
                  //       icon: const Icon(Icons.arrow_back_ios),
                  //       iconSize: 30,
                  //     ),
                  //   ],
                  // ),
                  Row(
                    children: [
                      // IconButton(
                      //   onPressed: () {
                      //     print("Back Here");
                      //     // Navigator.push(
                      //     //     context,
                      //     //     MaterialPageRoute(
                      //     //         builder: (context) => const HomePage()));
                      //   },
                      //   icon: const Icon(Icons.lightbulb_outline),
                      //   iconSize: 30,
                      // ),
                      IconButton(
                        onPressed: () {
                          print("Back Here");
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const HomePage()));
                        },
                        icon: const Icon(Icons.settings),
                        iconSize: 30,
                      ),
                    ],
                  ),
                ],
              ),

              // Dashboard
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20, left: 20, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Lượt chơi",
                            style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 1,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          Text(
                            "$tries/12",
                            style: const TextStyle(
                              color: Colors.black,
                              letterSpacing: 1,
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20, left: 20, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Điểm số",
                            style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 1,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          Text(
                            // timeLeft.toString(),
                            "$score",
                            style: const TextStyle(
                              color: Colors.black,
                              letterSpacing: 1,
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              // Games
              _isLoading
                  ? Expanded(
                      child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Cấp Độ $level",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SpinKitPouringHourGlassRefined(
                            color: Color(0xff0081c9),
                            size: 100,
                            duration: Duration(seconds: 1),
                          ),
                        ],
                      ),
                    ))
                  : Expanded(
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              child: GridView(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 20, right: 20, bottom: 10),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: numOfRow),
                                children:
                                    List.generate(visiblePairs.length, (index) {
                                  return Tile(
                                    imageAssetPath:
                                        visiblePairs[index].getImageAssetPath(),
                                    parent: this,
                                    tileIndex: index,
                                  );
                                }),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _showOverlay,
                            child: Center(
                              child: Container(
                                child: CircularPercentIndicator(
                                  circularStrokeCap: CircularStrokeCap.round,
                                  percent: percent / 3,
                                  animation: true,
                                  animateFromLastPercent: true,
                                  radius: 70.0,
                                  lineWidth: 10.0,
                                  progressColor: Colors.blueAccent,
                                  center: Text(
                                    "$percent",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 70,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _showSuccess,
                            child: Center(
                              child: Container(
                                child: Lottie.asset(
                                    'assets/animations/success.json',
                                    height: 200,
                                    repeat: true,
                                    reverse: true,
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _showFail,
                            child: Center(
                              child: Container(
                                child: Lottie.asset(
                                  'assets/animations/fail.json',
                                  height: 200,
                                  repeat: true,
                                  reverse: true,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class Tile extends StatefulWidget {
  String imageAssetPath;
  int tileIndex;
  _GameOneState parent;
  Tile({
    required this.imageAssetPath,
    required this.parent,
    required this.tileIndex,
  });

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.parent._disableTap
          ? null
          : () {
              // print("You click me");
              print(selected);
              print("---------");
              if (!selected) {
                if (store.contains(widget.tileIndex) == true) {
                  // Not check
                  print("Not check");
                } else {
                  // Save các ô đã được chọn (Check here)
                  store.add(widget.tileIndex);
                  setState(() {
                    pairs[widget.tileIndex].setIsSelected(true);
                  });

                  if (selectedImageAssetPath == '') {
                    selectedTileIndex = widget.tileIndex;
                    selectedImageAssetPath =
                        pairs[widget.tileIndex].getImageAssetPath();
                    print(selectedTileIndex);
                    print(selectedImageAssetPath);

                    if (selectedImageAssetPath == "assets/blue.png") {
                      // Correct
                      print("Correct");
                      numOfCorrect++;
                      score += 200;
                      widget.parent.disableTap();
                    } else {
                      // Wrong
                      print("Wrong");
                      numOfWrong++;
                      widget.parent.disableTap();

                      // Set result
                      indexResult.add(widget.tileIndex);
                      print("Index result: $indexResult");
                    }
                    selectedImageAssetPath = '';

                    // continue
                    if (numOfWrong == error ||
                        numOfCorrect == widget.parent.highlight ||
                        timeLeft == 0) {
                      // End tries game
                      print("End tries game");
                      widget.parent.stopTimer();
                      indexResult = [];
                      if (tries < 5) {
                        // exist wrong
                        if (numOfWrong <= error && numOfWrong > 0) {
                          setState(() {
                            widget.parent._disableTap = true;
                          });
                          widget.parent.screenLevelDown();
                          // Future.delayed(Duration(seconds: 4), () {
                          //   setState(() {
                          //     widget.parent.levelDown();
                          //   });
                          // });
                          widget.parent._timerLevel =
                              Timer(Duration(seconds: 4), () {
                            setState(() {
                              widget.parent.levelDown();
                            });
                          });
                        }

                        // all correct
                        if (numOfCorrect == widget.parent.highlight &&
                            numOfWrong == 0) {
                          // Hiện icon trong 3s

                          print("all");
                          setState(() {
                            widget.parent._disableTap = true;
                          });
                          widget.parent.showSuccess();

                          // Future.delayed(Duration(seconds: 3), () {
                          //   setState(() {
                          //     widget.parent.levelUp();
                          //   });
                          // });
                          widget.parent._timerLevel =
                              Timer(Duration(seconds: 3), () {
                            setState(() {
                              score += 100 * level;
                              widget.parent.levelUp();
                            });
                          });
                        }
                      } else {
                        print("END");
                        if (maxLevel < level) {
                          maxLevel = level;
                        }
                        print("level: $level");
                        print("maxLevel: $maxLevel");
                        widget.parent.stopTimer();
                        if (numOfCorrect == widget.parent.highlight &&
                            numOfWrong == 0) {
                          setState(() {
                            widget.parent._disableTap = true;
                          });
                          widget.parent.showSuccess();
                          widget.parent._timerGoResult =
                              Timer(Duration(seconds: 4), () {
                            setState(() {
                              // widget.parent.navigationPage();
                            });
                          });
                        }
                        if (numOfWrong <= error && numOfWrong > 0) {
                          setState(() {
                            widget.parent._disableTap = true;
                          });
                          widget.parent.screenLevelDown();
                          widget.parent._timerGoResult =
                              Timer(Duration(seconds: 4), () {
                            setState(() {
                              // widget.parent.navigationPage();
                            });
                          });
                        }
                      }
                    }
                  }

                  // print(widget.tileIndex);
                  // print(pairs[widget.tileIndex].getIsSelected());
                  // print(pairs[widget.tileIndex].getImageAssetPath());
                  // print(widget.imageAssetPath);
                }
              }
            },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 10,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(pairs[widget.tileIndex].getIsSelected()
                ? pairs[widget.tileIndex].getImageAssetPath() ==
                        "assets/blue.png"
                    ? pairs[widget.tileIndex].getImageAssetPath()
                    : "assets/red.png"
                : widget.imageAssetPath),
          ),
        ),
      ),
    );
  }
}
