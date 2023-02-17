import 'dart:async';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:brain_application/data/data_onborad/data_languages_2.dart';
import 'package:brain_application/theme_color/light_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:brain_application/general/check_languages.dart';
import 'package:brain_application/widgets/components/toast.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../widgets/components/custom_button.dart';

class LanguagesFirstWord extends StatefulWidget {
  const LanguagesFirstWord({super.key});

  @override
  State<LanguagesFirstWord> createState() => _LanguagesFirstWordState();
}

class _LanguagesFirstWordState extends State<LanguagesFirstWord> {
  String listWord = "lib/data/data_language/question_languages_two.json";
  String total_dictionary = "lib/data/data_language/total_dictionary.json";
  final int answerDurationInSeconds = 300;
  List<String> _firstWord = [""];
  List<String> _userWord = [];
  List<String> _usedWord = [];
  String wordInput = "";
  int statusCode = 0;
  bool stopTime = false;
  int numberWord = 0;
  bool back = false;
  int reduceSecondsBy = 1;
  int score = 0;
  String firstWord = "";
  // int currentIndex = 0;
  String firstCharacter = "";
  List wordList = [];
  Timer? countdownTimer;
  TextEditingController controllerInput = TextEditingController();
  Duration timeDuration = const Duration();

  @override
  void initState() {
    super.initState();
    setStartLetter();
    fetchRandomCharacter();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    countdownTimer!.cancel();
    controllerInput.dispose();
  }

  setStartLetter() async {
    // Obtain shared preferences.
    final wordUsedLanguage2 = await SharedPreferences.getInstance();
    List<String>? _wordUsedLanguage2 = wordUsedLanguage2.getStringList("wordUsedLanguage2");
    setState(() {
      _usedWord =_wordUsedLanguage2!.toList();
    });
  }

  void setEndTimer() {
    countdownTimer!.cancel();
    _showNotify("Hết giờ", "$score", () {
      Navigator.of(context).pop();
      setState(() {
        timeDuration = const Duration();
        score = 0;
        _firstWord = [''];
        _userWord = [];
        numberWord = 0;
        firstWord = "";
        wordInput = "";
        fetchRandomCharacter();
        controllerInput.clear();
        startTimer();
      });
    });
  }

  void setCountDown() {
    if (stopTime == false) {
      reduceSecondsBy = 1;
    } else {
      reduceSecondsBy = 0;
    }
    setState(() {
      final seconds = timeDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        setEndTimer();
      } else {
        timeDuration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer() {
    timeDuration = Duration(seconds: answerDurationInSeconds);
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  Future<bool> checkValidWord(String value) async {
    // Map<String, String> headers = {"Content-type": "application/json"};
    // final response = await http.post(Uri.parse("$validlanguagesUrl"),
    //     headers: headers, body: jsonEncode({"text": value}));
    // if (response.statusCode == 200) {
    //   return true;
    // }
    // return false;

    final String response = await rootBundle.loadString(total_dictionary);
    final data = await json.decode(response);
    print(data["word"].length);

    // data["word"].length
    for (var i = 0; i < data["word"].length; i++) {
      String firstCharacter2 = data["word"][i];
      // print(value);
      if (value == firstCharacter2) {
        // print(value);
        // print(firstCharacter2);
        return true;
      }
    }

    return false;
  }

  Future<bool> checkMatchWord(String value) async {
    // String userAnswer = controllerInput.text;
    // for (int i = 0; i < _firstWord.length; i++) {
    //   if ("$userAnswer" == _firstWord[i]) {
    //     return false;
    //   }
    // }
    // return true;
    for (int i = 0; i < _userWord.length; i++) {
      if (value == _userWord[i]) {
        return false;
      }
    }
    return true;
  }

  Future<bool> randomLetter(String value) async {
    final String response = await rootBundle.loadString(listWord);
    final data = await json.decode(response);
    for (int i = 0; i < _usedWord.length; i++) {
      if (value == _usedWord[i]) {
        return false;
      }
    }
    return true;
  }

  Future<void> fetchRandomCharacter() async {
    final String response = await rootBundle.loadString(listWord);
    final data = await json.decode(response);
    final wordUsedLanguage2 = await SharedPreferences.getInstance();
    int currentIndex = Random().nextInt(data["word"].length);
    // String tempAge = currentIndex.toString();
    // bool checkramdomLetter = await randomLetter(tempAge);

    // if(!checkramdomLetter && _usedWord.length  >= (data["word"].length )){
    //   _usedWord = ["0"];
    // }
    // if(!checkramdomLetter && _usedWord.length < (data["word"].length)  ){
    //
    //   fetchRandomCharacter();
    // }
    //
    // if(checkramdomLetter){
    //   firstCharacter = data["word"][currentIndex].split(' ')[0];
    //   // print("day laf char $firstCharacter");
    //   String tempAge1 = currentIndex.toString();
    //   _usedWord.add(tempAge1);
    //
    //   wordUsedLanguage2.setStringList('wordUsedLanguage2', _usedWord);
    // }

    String firstCharacter = data["word"][currentIndex].split(' ')[0];
    print(firstCharacter);
    bool checkramdomLetter = await randomLetter(firstCharacter);


    setState(() {
      // String firstCharacter = data["word"][currentIndex].split(' ')[0];
      // _firstWord.add(firstCharacter);
      // firstWord = _firstWord[1];
      // wordList = data["word"];

      if(checkramdomLetter){
        _firstWord.add(firstCharacter);
        firstWord = _firstWord[1] ;
        wordList = data["word"];
        _usedWord.add(firstCharacter);
        wordUsedLanguage2.setStringList('wordUsedLanguage2', _usedWord);
        print(_usedWord);
      }
      else if(!checkramdomLetter && (_usedWord.length < data["word"].length)){
        fetchRandomCharacter();
      }
      else if(!checkramdomLetter && (_usedWord.length >= data["word"].length)){
        _usedWord=[];
        fetchRandomCharacter();
      }

      // _firstWord.add(firstCharacter);


      print(_usedWord);
    });
  }

  void handleClickCheck() async {
    String userAnswer = controllerInput.text;
    String firstWord = _firstWord[1];
    numberWord = _firstWord.length - 1;
    String checkingWord = "$firstWord $userAnswer";
    bool isValidWord = await checkValidWord(checkingWord);
    bool isMatchWord = await checkMatchWord(checkingWord);
    if (!isMatchWord) {
      showToastErrorMatch();
    }
    if (!isValidWord) {
      showToastError();
    }

    if (isValidWord && isMatchWord) {
      _userWord.add(checkingWord);
      score += 200;
      showToastCorrect("+ 200");
    }
    setState(() {
      controllerInput.clear();
      wordInput = "";
    });
  }

  void handleCheckResult() {
    if (wordInput.isNotEmpty) {
      handleClickCheck();
    }
  }

  Future<void> _dialogBuilderTwo(BuildContext context) {
    final obController = OnBoardingLanguageTwo();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async {
          // final back = await showMyDialog(context);
          return false;
        },
        child: Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              LiquidSwipe(
                pages: obController.pages,
                enableSideReveal: true,
                liquidController: obController.controller,
                onPageChangeCallback: obController.onPageChangedCallback,
                slideIconWidget: const Icon(Icons.arrow_back_ios),
                waveType: WaveType.liquidReveal,
              ),
              Positioned(
                top: 50,
                right: 20,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    stopTime = false;
                  },
                  child:
                      const Text("Skip", style: TextStyle(color: Colors.grey)),
                ),
              ),
              Obx(
                () => Positioned(
                  bottom: 10,
                  child: AnimatedSmoothIndicator(
                    count: 3,
                    activeIndex: obController.currentPage.value,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: Color(0xff272727),
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

  Future<void> _showNotify(
      String title, String content, Function callback) async {
    final size = MediaQuery.of(context).size;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(title,
                maxLines: 1,
                minFontSize: 16,
                style: const TextStyle(
                    fontSize: 40,
                    color: Colors.red,
                    decoration: TextDecoration.none),
                textAlign: TextAlign.center),
          ),
          Container(
            width:  size.width * 0.1,
            margin: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: [Color(0xFFFFF9C4), Color(0xFFF9A825)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                const Positioned(
                  bottom: -3,
                  left: -5,
                  right: -250,
                  child: Image(
                    image: AssetImage('assets/images/cat-clap.gif'),
                    height: 100,
                    width: 200,
                    //   width:400,
                  ),
                ),
                Positioned(
                  bottom: -30,
                  left: -5,
                  right: -5,
                  child: Image.asset(
                    'assets/images/roi.png',
                    width: 700,
                    height: 400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      AutoSizeText(
                        "Số từ đúng: $numberWord",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        minFontSize: 16,
                        style: const TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            decoration: TextDecoration.none),
                      ),
                      const SizedBox(height: 10),
                      AutoSizeText(
                        "Điểm của bạn:        ",
                        maxLines: 2,
                        minFontSize: 16,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            decoration: TextDecoration.none),
                      ),
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/poly-twist-knots.png',
                                  width: 170,
                                ),
                                AutoSizeText(
                                  content,
                                  maxLines: 1,
                                  minFontSize: 16,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      decoration: TextDecoration.none),
                                ),
                              ],
                            ),

                          ),
                        ],
                      ),
                      AutoSizeText(
                        "Danh sách từ đúng:$_userWord",
                        textAlign: TextAlign.center,

                        minFontSize: 16,
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CustomButton(
            padding: 0,
            text: 'Chơi Lại',
            onPressed: () => callback(),
          ),
        ],
      ),
    );
  }

  Future<bool?> showMyDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bạn có muốn thoát ra ?'),
          actions: [
            TextButton(
              child: Text('Không'),
              onPressed: () {
                back = false;
                Navigator.pop(context, back);
              },
            ),
            TextButton(
              child: Text('Có'),
              onPressed: () async {
                back = true;
                Navigator.pop(context, back);
                final wordUsedLanguage2 = await SharedPreferences.getInstance();
                await wordUsedLanguage2.setStringList('wordUsedLanguage2', _usedWord);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(size.height);
    print(size.width);

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
                left: -290,
                right: -5,
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
                  Expanded(
                    flex: 2,
                    child: Container(
                      // margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
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
                                          IconButton(
                                            onPressed: () {
                                              // stopTime = true;
                                              setEndTimer();
                                            },
                                            icon: const Icon(
                                              Icons.flag_circle_rounded,
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
                                              _dialogBuilderTwo(context);
                                              stopTime = true;
                                            },
                                            icon: const Icon(
                                              Icons.question_mark_rounded,
                                              size: 35,
                                            ),
                                            color: Colors.black,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              stopTime = true;
                                              _dialogBuilderTwo(context);
                                            },
                                            icon: const Icon(
                                              Icons.settings,
                                              size: 35,
                                            ),
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  height:  size.height*0.04,
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
                                          // final questions = ref.watch(questionsProvider);
                                          return FractionallySizedBox(
                                            alignment: Alignment.centerLeft,
                                            widthFactor:
                                                timeDuration.inSeconds /
                                                    answerDurationInSeconds,
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
                                                '${timeDuration.inSeconds} seconds');
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
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          width: size.width,
                                          margin: const EdgeInsets.only(
                                            top: 20,
                                            bottom: 20,
                                            left: 20,
                                            right: 20,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6, horizontal: 22),
                                          height:  size.height*0.2,
                                          decoration: BoxDecoration(
                                            color: LightColors.kLightYellow,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 30,
                                                  bottom: 10,
                                                ),
                                                child: AutoSizeText(
                                                    "Nhập từ thích hợp bắt đầu bằng chữ $firstWord : ",
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    maxFontSize: 80,
                                                    minFontSize: 16,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 20)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20, bottom: 20),
                                                child: AutoSizeText(
                                                    wordInput == ""
                                                        ? "$firstWord _____"
                                                        : "$firstWord $wordInput",
                                                    maxLines: 1,
                                                    minFontSize: 16,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 20)),
                                              ),
                                            ],
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
                      ),
                    ),
                  ),
                  Container(
                    // Add the line below
                    margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                    // padding: const EdgeInsets.all(16),
                    clipBehavior: Clip.hardEdge,
                    height:  size.height * 0.01,
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
                    height: size.height * 0.01,
                    decoration: const BoxDecoration(
                      color: Color(0xfffff3e0),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        SizedBox(
                          width: size.width * 0.5,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            child: TextField(
                              controller: controllerInput,
                              textAlign: TextAlign.center,
                              maxLength: 7,
                              onChanged: (text) {
                                setState(() {
                                  wordInput = text;
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: "nhập từ ở đây",
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                handleCheckResult();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.yellow[600],
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 14),
                                  textStyle: const TextStyle(fontSize: 24)),
                              child: AutoSizeText('Gửi',
                                  maxLines: 1,
                                  minFontSize: 16,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20)),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
