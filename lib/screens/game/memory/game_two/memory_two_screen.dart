import 'dart:async';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:brain_application/screens/game/memory/result_screen_m2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:brain_application/data/data_memory/data_memory_two.dart';
import 'package:lottie/lottie.dart';

import 'level.dart';

class MemoryTwoScreen extends StatefulWidget {
  final String levelValue;
  const MemoryTwoScreen({required this.levelValue});

  @override
  State<MemoryTwoScreen> createState() => _MemoryTwoScreenState();
}

class _MemoryTwoScreenState extends State<MemoryTwoScreen> {
  bool _showSuccess = false;
  bool _disableTap = false;
  bool _showFail = false;
  bool _end = false;
  bool _isSwitch = false;
  Timer? timer;
  bool _isLoading = false;
  int? card;

  final double runSpacing = 5;
  final double spacing = 1;
  int columns = 0;

  checkLevelValue() {
    if (widget.levelValue == "Easy") {
      pairs = listOfEasy[Random().nextInt(3)];
    } else if (widget.levelValue == "Medium") {
      pairs = listOfMedium[Random().nextInt(2)];
    } else if (widget.levelValue == "Difficult") {
      pairs = getShape();
    }
  }

  setCard() {
    checkLevelValue();
    if (pairs.length == 80 || pairs.length == 85) {
      card = 45;
    } else if (pairs.length == 28) {
      card = 25;
    }
  }

  getColumn() {
    if (getImg.length <= 12) {
      columns = 3;
    } else if (getImg.length <= 24) {
      columns = 4;
    } else if (getImg.length <= 35) {
      columns = 5;
    } else if (getImg.length <= 50) {
      columns = 6;
    }
    return columns;
  }

  start() {
    _disableTap = false;
    _isSwitch = true;
    getImg = pickRandomItemsAsListWithSubList(pairs, 3);
    getImg.shuffle();
    getColumn();
    selectedImageAssetPath = [];
  }

  next() async {
    getImg = getImg
        .where((element) =>
            selectedImageAssetPath.contains(element.imageAssetPath))
        .toList();
    pairs.removeWhere(
        (element) => selectedImageAssetPath.contains(element.imageAssetPath));
    getImg += pickRandomItemsAsListWithSubList(pairs, 3);
    getImg.shuffle();
    getColumn();
  }

  getResult() {
    remain = getImg
        .where((element) =>
            !selectedImageAssetPath.contains(element.imageAssetPath))
        .toList();
    indicesOfRemain = remain.map((element) => getImg.indexOf(element)).toList();
    // print("Remain: $remain");
    print("Indices: $indicesOfRemain");
    return indicesOfRemain;
  }

  // navigationPage() {
  //   setState(() {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => ResultPage()),
  //     );
  //   });
  // }

  Timer? _timerLoad;
  isLoading() {
    _isLoading = true;
    _timerLoad = Timer(Duration(seconds: 1), () {
      setState(() {
        next();
        _isLoading = false;
        _disableTap = false;
        next();
      });
    });
  }

  // Animation of success
  Timer? _timerSuccess;
  showSuccess() {
    _showSuccess = true;
    _timerSuccess = Timer(Duration(seconds: 1), () {
      setState(() {
        _showSuccess = false;
      });
    });
  }

  showFail() {
    _showFail = true;
    _timerSuccess = Timer(Duration(seconds: 2), () {
      setState(() {
        _showFail = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    tries = 1;
    // checkLevelValue();
    setCard();
    start();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timerSuccess!.cancel();
    timer!.cancel();
    _timerLoad!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = (MediaQuery.of(context).size.width - runSpacing * (columns - 1)) /
        columns;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffe5f6fe),
        body: Container(
          // width: screen_width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icons
              Row(
                // crossAxisAlignment: CrossAxisAlignment.spaceBetween,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          print("Back Here");
                          // Navigator.pop(context);
                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LevelScreen()));
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                        iconSize: 30,
                      ),
                    ],
                  ),
                  const Text(
                    "Lượt chơi",
                    style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 1,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                // color: Colors.amber,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // const Text(
                          //   "Lượt chơi",
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     letterSpacing: 1,
                          //     fontSize: 24,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          Text(
                            "$tries/2",
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
                  ],
                ),
              ),

              // Game
              _isLoading
                  ? Expanded(
                      child: Container(),
                    )
                  : Expanded(
                      child: Stack(
                        children: [
                          Center(
                            child: Wrap(
                              runSpacing: runSpacing,
                              spacing: spacing,
                              alignment: WrapAlignment.center,
                              children: List.generate(getImg.length, (index) {
                                getResult();
                                return SizedBox(
                                  width: w,
                                  height: w,
                                  child: Tile(
                                    imageAssetPath:
                                        getImg[index].getImageAssetPath(),
                                    tileIndex: index,
                                    parent: this,
                                    isBorder: indicesOfRemain.contains(index),
                                  ),
                                );
                              }),
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
  _MemoryTwoScreenState parent;
  final bool isBorder;

  Tile({
    required this.imageAssetPath,
    required this.tileIndex,
    required this.parent,
    required this.isBorder,
  });

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.parent._disableTap
          ? null
          : () {
              if (!selected) {
                print("Click me");

                selectedTileIndex = widget.tileIndex;
                print("selectedTileIndex: $selectedTileIndex");

                widget.parent.setState(() {
                  widget.parent._disableTap = true;
                });
                setState(() {
                  _isSelected = true;
                });
                // *Check selectedImageAssetPath exist image
                // * if exist => Wrong
                // *else not exist => Correct
                checkString = selectedImageAssetPath.where((element) =>
                    element == getImg[widget.tileIndex].getImageAssetPath());
                print("CheckString: $checkString");

                if (checkString.isEmpty) {
                  // *Correct
                  print("Correct");
                  selectedImageAssetPath
                      .add(getImg[widget.tileIndex].getImageAssetPath());

                  print("selectedImageAssetPath: $selectedImageAssetPath");
                  print("Length: ${selectedImageAssetPath.length}");

                  if (selectedImageAssetPath.length == widget.parent.card) {
                    // *All correct (lượt 1)
                    if (tries < 2) {
                      // *End Trie
                      print("END TRIES");
                      widget.parent.showSuccess();
                      widget.parent.timer = Timer(Duration(seconds: 1), () {
                        widget.parent.setState(() {
                          _isSelected = false;
                          widget.parent.start();
                          tries++;
                        });
                      });
                    } else {
                      // * End games when all correct (lượt 2)
                      widget.parent.showSuccess();
                      widget.parent.timer = Timer(Duration(seconds: 2), () {
                        widget.parent.setState(() {
                          _isSelected = false;
                        });
                      });

                      widget.parent.timer = Timer(Duration(seconds: 3), () {
                        widget.parent.setState(() {
                          widget.parent._isSwitch = false;
                          widget.parent._end = true;
                        });
                      });

                      // widget.parent.timer = Timer(Duration(seconds: 5), () {
                      //   widget.parent.setState(() {
                      //     widget.parent.navigationPage();
                      //   });
                      // });
                    }
                  } else {
                    // *Correct => Continue
                    widget.parent.showSuccess();

                    widget.parent.timer = Timer(Duration(seconds: 1), () async {
                      widget.parent.setState(() {
                        widget.parent.isLoading();
                        _isSelected = false;
                      });
                    });
                  }
                } else {
                  if (tries < 2) {
                    // *Wrong => END TRIES (lượt 1)
                    print("Wrong/END TRIES");
                    widget.parent.showFail();
                    widget.parent.timer = Timer(Duration(seconds: 2), () {
                      widget.parent.setState(() {
                        _isSelected = false;
                      });
                    });

                    widget.parent.timer = Timer(Duration(seconds: 3), () {
                      widget.parent.setState(() {
                        widget.parent._isSwitch = false;
                        widget.parent._end = true;
                      });
                    });

                    widget.parent.timer = Timer(Duration(seconds: 5), () {
                      widget.parent.setState(() {
                        widget.parent.start();
                        tries++;
                      });
                    });
                  } else {
                    // * End games when wrong (lượt 2)
                    widget.parent.showFail();
                    widget.parent.timer = Timer(Duration(seconds: 2), () {
                      widget.parent.setState(() {
                        _isSelected = false;
                      });
                    });

                    widget.parent.timer = Timer(Duration(seconds: 3), () {
                      widget.parent.setState(() {
                        widget.parent._isSwitch = false;
                        widget.parent._end = true;
                      });
                    });

                    // widget.parent.timer = Timer(Duration(seconds: 5), () {
                    //   widget.parent.setState(() {
                    //     widget.parent.navigationPage();
                    //   });
                    // });
                  }
                }
              }
            },
      child: Card(
        shape: RoundedRectangleBorder(
          side: widget.parent._isSwitch
              ? _isSelected
                  ? BorderSide(color: Colors.blue, width: 3)
                  : BorderSide.none
              : widget.parent._end
                  ? widget.isBorder
                      ? BorderSide(color: Colors.blue, width: 3)
                      : BorderSide.none
                  : BorderSide.none,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(widget.imageAssetPath),
          ),
        ),
      ),
    );
  }
}
