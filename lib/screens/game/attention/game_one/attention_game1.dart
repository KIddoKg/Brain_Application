import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brain_application/theme_color/light_colors.dart';
// import 'package:brain_training/utils/helper.dart';
// import 'package:brain_training/utils/custom_dialog.dart';
// import 'package:brain_training/constants/color.dart';
// import 'package:brain_training/widget/clock.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:brain_application/widgets/components/custom_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ImagePass.dart';
import 'ResultTest.dart';

class AttentionGameOne extends StatefulWidget {
  const AttentionGameOne({super.key});

  @override
  State<AttentionGameOne> createState() => _AttentionGameOneState();
}

class Result {
  final int score;
  final String message;

  Result(this.score, this.message);
}

class ImagePass {
  // final int score;
  final String score;
  final List<String> message;

  ImagePass(this.score, this.message);
}

class _AttentionGameOneState extends State<AttentionGameOne> {
  final int totalDurationInSeconds = 120;
  final int answerDurationInSeconds = 60;
  final int POINT_PER_CORRECT_ANSWER = 200;
  int count = 0;
  final String game1_attention =
      "lib/data/data_attention/game_one_attention.json";
  final String key_data = "attentionData";

  late double screenHeight, screenWidth, boxHeight, boxWidth;

  Timer? questionCountdownTimer;
  Duration questionDuration = const Duration();
  Timer? totalCountdownTimer;
  Duration totalDuration = const Duration();

  List<String> imagesAssetPath = [];
  List<String> solutionAssetPath = [];
  List<String> solutionAssetPathUsed = [];
  List<String> imagesAssetPathUsed = [];
  List gameData = [];
  late int currentKey; // ID of image key

  int currentQuestion = 0; // order of question
  int point = 0;
  int totalAnswerTime = 0;

  bool back = false;
  bool isCorrect = false;
  bool endGame = false;
  late double scaleRatio;
  late CustomDialog dialog;

  setImageUsed() async {
    // Obtain shared preferences.
    final imageUsedAttendtion1 = await SharedPreferences.getInstance();
    List<String>? _imageUsedAttendtion1 =
        imageUsedAttendtion1.getStringList("imageUsedAttendtion1");
    final imageSolutionAttendtion1 = await SharedPreferences.getInstance();
    List<String>? _imageSolutionAttendtion1 =
        imageSolutionAttendtion1.getStringList("imageSolutionAttendtion1");
    setState(() {
      imagesAssetPathUsed = _imageUsedAttendtion1!.toList();
      solutionAssetPathUsed = _imageSolutionAttendtion1!.toList();
      print(solutionAssetPathUsed);
      // imagesAssetPathUsed =["assets/images/Attention/Question/6.png", "assets/images/Attention/Question/12.png", "assets/images/Attention/Question/11.png", "assets/images/Attention/Question/1.png", "assets/images/Attention/Question/21.png," "assets/images/Attention/Question/5.png", "assets/images/Attention/Question/14.png"," assets/images/Attention/Question/4.png", "assets/images/Attention/Question/18.png", "assets/images/Attention/Question/24.png","assets/images/Attention/Question/19.png", "assets/images/Attention/Question/30.png", "assets/images/Attention/Question/9.png"," assets/images/Attention/Question/36.png", "assets/images/Attention/Question/7.png", "assets/images/Attention/Question/16.png", "assets/images/Attention/Question/31.png", "assets/images/Attention/Question/34.png", "assets/images/Attention/Question/28.png", "assets/images/Attention/Question/37.png", "assets/images/Attention/Question/2.png," "assets/images/Attention/Question/20.png", "assets/images/Attention/Question/10.png"," assets/images/Attention/Question/35.png", "assets/images/Attention/Question/8.png", "assets/images/Attention/Question/27.png", "assets/images/Attention/Question/38.png", "assets/images/Attention/Question/26.png", "assets/images/Attention/Question/22.png", "assets/images/Attention/Question/29.png", "assets/images/Attention/Question/3.png", "assets/images/Attention/Question/15.png", "assets/images/Attention/Question/40.png", "assets/images/Attention/Question/13.png", "assets/images/Attention/Question/23.png","assets/images/Attention/Question/35.png", "assets/images/Attention/Question/17.png", "assets/images/Attention/Question/4.png", "assets/images/Attention/Question/21.png", "assets/images/Attention/Question/20.png", "assets/images/Attention/Question/39.png", "assets/images/Attention/Question/2.png", "assets/images/Attention/Question/5.png", "assets/images/Attention/Question/36.png", "assets/images/Attention/Question/25.png"]
      // ;
    });
  }

  // Timer
  void startQuestionTimer() {
    questionDuration = Duration(seconds: answerDurationInSeconds);
    questionCountdownTimer = Timer.periodic(
        const Duration(seconds: 1), (_) => setQuestionCountDown());
  }

  void startTotalTimer() {
    setImageUsed();
    totalDuration = Duration(seconds: totalDurationInSeconds);
    totalCountdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setTotalCountDown());
  }

  void setQuestionCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = questionDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        outOfQuestionTime();
      } else {
        questionDuration = Duration(seconds: seconds);
      }
    });
  }

  void setTotalCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = totalDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        handleEndGame();
      } else {
        totalDuration = Duration(seconds: seconds);
      }
    });
  }

  void setCancelQuestionTimer() {
    questionCountdownTimer!.cancel();
  }

  void setCancelTotalTimer() {
    totalCountdownTimer!.cancel();
  }

  // Timer Logic
  Future<void> outOfQuestionTime() async {
    setCancelQuestionTimer();
    final imageUsedAttendtion1 = await SharedPreferences.getInstance();
    await imageUsedAttendtion1.setStringList(
        'imageUsedAttendtion1', imagesAssetPathUsed);
    final imageSolutionAttendtion1 = await SharedPreferences.getInstance();
    await imageSolutionAttendtion1.setStringList(
        'imageSolutionAttendtion1', solutionAssetPathUsed);
    CountCorrect();
    if (checkEndGame()) {
      return handleEndGame();
    }
    nextQuestion();
  }

  // Question Logic
  void nextQuestion() {
    // if(imagesAssetPath.length == currentQuestion+1){
    //   handleEndGame();
    // }
    setState(() {
      isCorrect = false;
      currentQuestion++;
      currentKey = getCurrentKeyValue(imagesAssetPath[currentQuestion]);
    });
    scaleRatio = calculateImageScale(currentKey);
    startQuestionTimer();
  }

  bool checkEndGame() {
    if (totalDuration.inSeconds < 0) {
      return true;
    }
    return false;
  }

  void imagePass() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ImagePassScreen(
              imagePass: ImagePass("o", solutionAssetPathUsed))),
    );
  }

  void handleEndGame() {
    setCancelQuestionTimer();
    setCancelTotalTimer();
    setState(() {
      endGame = true;
    });
    int correctAnswer = point ~/ POINT_PER_CORRECT_ANSWER;
    int avgTime = calculateAvgTime(correctAnswer);
    int bonusPoint = calculateBonusPoint(avgTime);
    int totalPoint = point + bonusPoint;

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ResultScreen(result: Result(totalPoint, 'Success!'))),
    );
    // dialog.show(
    //     Text("H???T GI???",
    //         textAlign: TextAlign.center,
    //         style: const TextStyle(
    //             color: Colors.red, fontSize: 40, fontWeight: FontWeight.w600)),
    //     SingleChildScrollView(
    //       child: ListBody(
    //         children: <Widget>[
    //           Text(
    //             "S??? v??ng ch??i v?????t qua: ${correctAnswer}",
    //             textAlign: TextAlign.center,
    //             style: const TextStyle(
    //                 fontSize: 22,
    //                 color: Colors.black,
    //                 decoration: TextDecoration.none),
    //           ),
    //           const SizedBox(height: 10),
    //           Text(
    //             "Th???i gian trung b??nh: ${avgTime} s",
    //             textAlign: TextAlign.center,
    //             style: const TextStyle(
    //                 fontSize: 23,
    //                 color: Colors.black,
    //                 decoration: TextDecoration.none),
    //           ),
    //           const SizedBox(height: 10),
    //           const Text(
    //             "??i???m c???a b???n:        ",
    //             textAlign: TextAlign.center,
    //             style: TextStyle(
    //                 fontSize: 25,
    //                 color: Colors.black,
    //                 decoration: TextDecoration.none),
    //           ),
    //           Stack(
    //             alignment: Alignment.topCenter,
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 10, bottom: 10),
    //                 child: Stack(
    //                   alignment: Alignment.center,
    //                   children: [
    //                     Image.asset(
    //                       'assets/images/poly-twist-knots.png',
    //                       width: 170,
    //                     ),
    //                     Text(
    //                       "$totalPoint",
    //                       textAlign: TextAlign.center,
    //                       style: const TextStyle(
    //                           color: Colors.black,
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 30,
    //                           decoration: TextDecoration.none),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //     [
    //       Container(
    //         margin: const EdgeInsets.only(bottom: 10),
    //         padding: const EdgeInsets.only(left: 50, right: 50),
    //         decoration: BoxDecoration(
    //           borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    //           color: Colors.orange,
    //         ),
    //         child: TextButton(
    //           child: const Text('Ch??i l???i',
    //               style: TextStyle(fontSize: 20, color: Colors.white)),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //             restartGame();
    //           },
    //         ),
    //       )
    //     ]);
  }

  void restartGame() {
    currentQuestion = 0;
    point = 0;
    totalAnswerTime = 0;

    isCorrect = false;
    endGame = false;

    setupImages();
    scaleRatio = calculateImageScale(currentKey);
    startTotalTimer();
    startQuestionTimer();
  }

  // Image & Image Data
  int getCurrentKeyValue(String imageName) {
    String key = imageName.split("/").last.split(".").first;
    return int.parse(key);
  }

  Future<void> _loadAssetsFiles() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    // Load Path
    final solutionImagePath = manifestMap.keys
        .where((String key) => key.contains('images/'))
        .where((String key) => key.contains('Attention/'))
        .where((String key) => key.contains('Solution/'))
        .where((String key) => key.contains('.png'))
        .toList();

    final attentionImagePath = manifestMap.keys
        .where((String key) => key.contains('images/'))
        .where((String key) => key.contains('Attention/'))
        .where((String key) => key.contains('Question/'))
        .where((String key) => key.contains('.png'))
        .toList();

    solutionAssetPath = solutionImagePath;
    attentionImagePath
        .removeWhere((element) => imagesAssetPathUsed.contains(element));
    if (attentionImagePath.length >= 12) {
      imagesAssetPath = attentionImagePath;
    }
  }

  void setupImages() {
    imagesAssetPath.shuffle();

    if (imagesAssetPath.isEmpty) {
      handleEndGame();
    }
    setState(() {
      currentKey = getCurrentKeyValue(imagesAssetPath[currentQuestion]);
    });
  }

  // Game Logic
  void onTapDown(BuildContext context, TapDownDetails details) {
    int imageOriginalWidth = gameData[currentKey - 1]["size"]["x"];
    int imageOriginalHeight = gameData[currentKey - 1]["size"]["y"];
    int resultOriginalWidth = gameData[currentKey - 1]["result"]["x"];
    int resultOriginalHeight = gameData[currentKey - 1]["result"]["y"];

    double resultXFromCenterImage =
        resultOriginalWidth - imageOriginalWidth / 2;
    double resultYFromCenterImage =
        resultOriginalHeight - imageOriginalHeight / 2;

    double posX = details.localPosition.dx;
    double posY = details.localPosition.dy;

    double resultX = boxWidth / 2 + resultXFromCenterImage * scaleRatio;
    double resultY = boxHeight / 2 + resultYFromCenterImage * scaleRatio;

    double validWidthRange =
        gameData[currentKey - 1]["valid_box"]["x"] * scaleRatio / 2;
    double validHeightRange =
        gameData[currentKey - 1]["valid_box"]["y"] * scaleRatio / 2;

    if (posX >= resultX - validWidthRange &&
        posX <= resultX + validWidthRange &&
        posY >= resultY - validHeightRange &&
        posY <= resultY + validHeightRange) {
      handleCorrectAnswer();
    }
  }

  Future<void> CountCorrect() async {
    if (isCorrect == true) {
      count++;
    } else if (isCorrect == false) {
      count = 0;
    }
    Set<String> uniqueItems = Set<String>.from(imagesAssetPathUsed);

    if (count >= 3) {
      for (var i = 0; i < count; i++) {
        uniqueItems.add(imagesAssetPath[currentQuestion - i]);
      }
      imagesAssetPathUsed = List<String>.from(uniqueItems);
      Set<String> uniqueSolutionItems = Set<String>.from(solutionAssetPathUsed);
      for (var i = 0; i < imagesAssetPathUsed.length; i++) {
        uniqueSolutionItems.add(solutionAssetPath.firstWhere((element) =>
            element.split("/").last == imagesAssetPathUsed[i].split("/").last));
      }
      solutionAssetPathUsed = List<String>.from(uniqueSolutionItems);
    }

    // setState(() {
    //   isCorrect = true;
    //   point += POINT_PER_CORRECT_ANSWER;
    //
    //
    // });
    // await Future.delayed(Duration(seconds: 3));
    // nextQuestion();
    // if (checkEndGame()) {
    //   handleEndGame();
    // }
  }

  Future<void> handleCorrectAnswer() async {
    setCancelQuestionTimer();
    totalAnswerTime += answerDurationInSeconds - questionDuration.inSeconds;

    setState(() {
      isCorrect = true;
      point += POINT_PER_CORRECT_ANSWER;
      // imagesAssetPathUsed.add(imagesAssetPath[currentQuestion]);
    });
    CountCorrect();
    await Future.delayed(Duration(seconds: 3));
    nextQuestion();
    if (checkEndGame()) {
      handleEndGame();
    }
  }

  double calculateImageScale(int key) {
    int imageOriginalWidth = gameData[key - 1]["size"]["x"];
    int imageOriginalHeight = gameData[key - 1]["size"]["y"];
    double widthRatio = imageOriginalWidth / boxWidth;
    double heightRatio = imageOriginalHeight / boxHeight;
    double result = 1.0;

    if (widthRatio > heightRatio && widthRatio > 1) {
      result = boxWidth / imageOriginalWidth;
    } else if (heightRatio > widthRatio && heightRatio > 1) {
      result = boxHeight / imageOriginalHeight;
    }

    return result;
  }

  int calculateAvgTime(int totalCorrectAnswers) {
    double averageTotalTime =
        totalCorrectAnswers != 0 ? totalAnswerTime / totalCorrectAnswers : 0.0;
    return averageTotalTime.round();
  }

  int calculateBonusPoint(int avgTime) {
    double bonusPoint = avgTime != 0 ? point / avgTime : 0.0;
    return bonusPoint.round();
  }

  Future<List> readJson(String filePath, String key) async {
    final String response = await rootBundle.loadString(filePath);
    final data = await json.decode(response);

    return data[key];
  }

  // Main
  @override
  void initState() {
    super.initState();
    setImageUsed();
    CountCorrect();
    dialog = CustomDialog(context: context);
    _loadAssetsFiles().then((val) {
      // setImageUsed();
      setupImages();
      readJson(game1_attention, key_data).then((imageData) {
        gameData = imageData;
        scaleRatio = calculateImageScale(currentKey);
        startTotalTimer();
        startQuestionTimer();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    setCancelQuestionTimer();
    setCancelTotalTimer();
  }

  Future<bool?> showMyDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('B???n c?? mu???n tho??t ra ?'),
          actions: [
            TextButton(
              child: Text('Kh??ng'),
              onPressed: () {
                back = false;
                Navigator.pop(context, back);
              },
            ),
            TextButton(
              child: Text('C??'),
              onPressed: () async {
                back = true;
                Navigator.pop(context, back);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int seconds = questionDuration.inSeconds;
    int totalSeconds = totalDuration.inSeconds;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    boxHeight = screenHeight * 0.5;
    boxWidth = screenWidth;

    return WillPopScope(
      onWillPop: () async {
        final back = await showMyDialog(context);
        return back ?? false;
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: LightColors.kLightYellow,
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              const Positioned(
                left: -5,
                right: -230,
                child: Image(
                  image: AssetImage('assets/images/cat.gif'),
                  height: 200,
                  width: 400,
                  //   width:400,
                ),
              ),

              // SvgPicture.asset(
              //   'assets/images/business-lady-do-multi-tasking.svg',
              //   // fit: BoxFit.fitHeight,
              //   height:200,
              //   width:400,
              // ),

              Column(
                children: [
                  Container(
                    // margin: const EdgeInsets.all(16),
                    height: 250,

                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFFFD740), Color(0xFFF9A825)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),

                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      // height:300,

                      body: Container(
                        child: Center(
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            final back =
                                                await showMyDialog(context);
                                            if (back == true) {
                                              Navigator.pop(context, back);
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.arrow_circle_left_outlined,
                                            size: 40,
                                          ),
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            // stopTime = true;
                                          },
                                          icon: const Icon(
                                            Icons.question_mark_rounded,
                                            size: 35,
                                          ),
                                          color: Colors.black,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            imagePass();
                                            // _dialogBuilderTwo(context);
                                          },
                                          icon: const Icon(
                                            Icons.settings,
                                            size: 35,
                                          ),
                                          color: Colors.black,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            // stopTime = true;
                                            // _dialogBuilderTwo(context);
                                          },
                                          icon: const Icon(
                                            Icons.settings,
                                            size: 35,
                                          ),
                                          color: Colors.black,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                height: 30,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: LightColors.kLightYellow,
                                ),
                                child: Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    Consumer(
                                      builder: (context, ref, child) {
                                        return FractionallySizedBox(
                                          alignment: Alignment.centerLeft,
                                          widthFactor: totalSeconds /
                                              totalDurationInSeconds,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: LightColors.kDarkGreen,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    Positioned(
                                      left: 10,
                                      child: Consumer(
                                        builder: (context, ref, child) {
                                          return Text(
                                              '${totalSeconds} seconds');
                                        },
                                      ),
                                    ),
                                    const Positioned(
                                      right: 10,
                                      child: Icon(
                                        Icons.timer,
                                        size: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, bottom: 10),
                                      child: Text(
                                        "??i???m: $point",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                            fontSize: 27),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, bottom: 10),
                                      child: Text(
                                        "Th???i gian: ${questionDuration.inSeconds} s",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                            fontSize: 27),
                                      ),
                                    ),
                                  ])

                              // Expanded(
                              //   flex: 3,
                              //   child: Column(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceAround,
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     children: [
                              //       Expanded(
                              //         flex: 1,
                              //         child: Container(
                              //           margin: const EdgeInsets.only(
                              //             top: 20,
                              //             bottom: 20,
                              //             left: 20,
                              //             right: 20,
                              //           ),
                              //           padding: const EdgeInsets.symmetric(
                              //               vertical: 6, horizontal: 22),
                              //           height: 200,
                              //           decoration: BoxDecoration(
                              //             color: LightColors.kLightYellow,
                              //             borderRadius:
                              //                 BorderRadius.circular(12),
                              //           ),
                              //           child: Column(
                              //             children: [
                              //               Padding(
                              //                 padding: const EdgeInsets.only(
                              //                   top: 30,
                              //                   bottom: 10,
                              //                 ),
                              //                 child: Text(
                              //                     "Nh???p t??? th??ch h???p b???t ?????u b???ng ch???  : ",
                              //                     textAlign: TextAlign.center,
                              //                     style: const TextStyle(
                              //                         fontWeight:
                              //                             FontWeight.bold,
                              //                         color: Colors.black,
                              //                         fontSize: 25)),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    // Add the line below
                    margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                    // padding: const EdgeInsets.all(16),
                    clipBehavior: Clip.hardEdge,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xffffe0b2),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40),
                      ),
                    ),
                  ),
                  Container(
                    // Add the line below
                    margin: const EdgeInsets.only(left: 35.0, right: 35.0),
                    clipBehavior: Clip.hardEdge,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xfffff3e0),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 30),
                      imagesAssetPath.isNotEmpty && gameData.isNotEmpty
                          ? Column(children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  gameData[currentKey - 1]["title"],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                  height: boxHeight,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Material(
                                          child: !isCorrect
                                              ? Ink.image(
                                                  image: AssetImage(
                                                      imagesAssetPath[
                                                          currentQuestion]),
                                                  fit: BoxFit.scaleDown,
                                                  child: InkWell(
                                                    onTapDown: !endGame
                                                        ? (TapDownDetails
                                                                details) =>
                                                            onTapDown(context,
                                                                details)
                                                        : null,
                                                  ))
                                              : Ink.image(
                                                  image: AssetImage(solutionAssetPath
                                                      .firstWhere((element) =>
                                                          element
                                                              .split("/")
                                                              .last ==
                                                          imagesAssetPath[
                                                                  currentQuestion]
                                                              .split("/")
                                                              .last)),
                                                  fit: BoxFit.scaleDown,
                                                ))))
                            ])
                          : Container(
                              child: Text(
                                "Hi???n t???i th?? vi???n c??u h???i ??ang ???????c c???p nh???p. B???n vui l??ng quay l???i sau nha !!!",
                                textAlign: TextAlign.center,
                              ),
                            ),
                    ],
                  )
                  //   Expanded(
                  //     flex: 1,
                  //     child: Column(
                  //       children: [
                  //         SizedBox(
                  //           width: 200,
                  //           child: Padding(
                  //             padding: const EdgeInsets.only(top: 5, bottom: 10),
                  //             child: TextField(
                  //               controller: controllerInput,
                  //               textAlign: TextAlign.center,
                  //               maxLength: 6,
                  //               style: TextStyle(color: Colors.black, fontSize: 25),
                  //               onChanged: (text) {
                  //                 setState(() {
                  //                   wordInput = text;
                  //                 });
                  //               },
                  //               decoration: const InputDecoration(
                  //                 hintText: "nh???p t??? ??? ????y",
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Padding(
                  //             padding: const EdgeInsets.only(top: 10),
                  //             child: ElevatedButton(
                  //               onPressed: () {
                  //                 handleCheckResult();
                  //               },
                  //               style: ElevatedButton.styleFrom(
                  //                   backgroundColor: Colors.yellow[600],
                  //                   padding: const EdgeInsets.symmetric(
                  //                       horizontal: 40, vertical: 14),
                  //                   textStyle: const TextStyle(fontSize: 24)),
                  //               child: const Text('G???i',
                  //                   style: TextStyle(
                  //                       fontWeight: FontWeight.bold,
                  //                       color: Colors.black,
                  //                       fontSize: 20)),
                  //             )),
                  //       ],
                  //     ),
                  //   ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
