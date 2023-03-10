import 'package:brain_application/screens/Signin_Screen.dart';
import 'package:brain_application/screens/Signup_Screen.dart';
import 'package:brain_application/screens/game/math/Math_Screen.dart';
import 'package:brain_application/screens/home/homepage.dart';

//Languages Game
import 'package:brain_application/screens/game/languages/Language_Screen.dart';
import 'package:brain_application/screens/game/languages/game_one/languaes_first_letter.dart';
import 'package:brain_application/screens/game/languages/game_three/languages_conjunction.dart';
import 'package:brain_application/screens/game/languages/game_two/languages_first_word.dart';
import 'package:brain_application/screens/game/languages/game_four/languages_word_sort.dart';
//Attention Game
import 'package:brain_application/screens/game/attention/game_three/attention_game3_level1.dart';
import 'package:brain_application/screens/game/attention/game_three/attention_game3_level2.dart';
import 'package:brain_application/screens/game/attention/game_three/attention_game3_level3.dart';
import 'package:brain_application/screens/game/attention/game_three/attention_game3_level4.dart';
import 'package:brain_application/screens/game/attention/game_three/attention_game3_level5.dart';
import 'package:brain_application/screens/game/attention/game_three/attention_game3_level6.dart';
import 'package:brain_application/screens/game/attention/game_three/attention_game3_level7.dart';
import 'package:brain_application/screens/game/attention/game_three/attention_game3_level8.dart';
import 'package:brain_application/screens/game/attention/game_three/attention_game3_level9.dart';
import 'package:brain_application/screens/game/attention/game_three/attention_game3_level10.dart';
import 'package:brain_application/screens/game/attention/game_three/menu_Level_game3.dart';
import 'package:brain_application/screens/game/attention/game_three/menu_Level_game3.dart';
import 'package:brain_application/screens/game/attention/Attention_Screen.dart';
// import 'package:brain_application/screens/game/attention/testgame3.dart';
import 'package:brain_application/screens/game/attention/game_one/attention_game1.dart';
import 'package:brain_application/screens/game/attention/game_two/attention_two_screen.dart';

//memory
import 'package:brain_application/screens/game/memory/Memory_Screen.dart';
import 'package:brain_application/screens/game/memory/game_one/memory_one_screen.dart';
import 'package:brain_application/screens/game/memory/game_two/memory_two_screen.dart';
import 'package:brain_application/screens/game/memory/game_three/memory_three_screen.dart';

//Admin

import 'package:brain_application/screens/admin/admin_page.dart';

//popup

import 'package:brain_application/screens/setting/Setting_Screen.dart';

import '../screens/game/memory/game_two/level.dart';

class RouteGenerator {
  const RouteGenerator._();

  static const signin = '/signin';
  static const signup = '/signup';
  static const homepage = '/homepage';
  static const setting = '/setting';
  static const mathScreen = '/mathScreen';
  static const gameMath1 = '/gameMath1';
  static const gameMath2 = '/gameMath2';

  //Languages Game
  static const languageScreen = '/languageScreen';
  static const gameLetter = '/gameLetter';
  static const gameWord = '/gameWord';
  static const gameConj = '/gameConj';
  static const gameSort = '/gameSort';
  // Memory Game
  static const memoryScreen = '/memoryScreen';
  static const gameMemory1 = 'gameMemory1';
  static const gameMemory2 = 'gameMemory2';
  static const gameMemory3 = 'gameMemory3';

  // Attention Game
  static const game3atte1 = 'game3atte1';
  static const game3atte2 = 'game3atte2';
  static const game3atte3 = 'game3atte3';
  static const game3atte4 = 'game3atte4';
  static const game3atte5 = 'game3atte5';
  static const game3atte6 = 'game3atte6';
  static const game3atte7 = 'game3atte7';
  static const game3atte8 = 'game3atte8';
  static const game3atte9 = 'game3atte9';
  static const game3atte10 = 'game3atte10';
  static const attentionScreen = '/attentionScreen';
  static const gametest = 'gametest';
  static const levelattengame3 = 'levelattengame3';
  static const game1Atten = '/game1Atten';
  static const game2Atten = '/game2Atten';

  //popup
  static const walkthrough_screen = '/walkthrough_screen';
  //admin_page

  static const admin_page2 = '/admin_page2';

  static final routes = {
    signin: (context) => const SigninScreen(),
    signup: (context) => const SignupScreen(),
    homepage: (context) => const Homepage(),
    setting: (context) => const SettingsScreen(),
    mathScreen: (context) => const MathScreen(),

    //Languages Game
    languageScreen: (context) => const LanguageScreen(),
    gameMemory1: (context) => const GameOne(),
    gameMemory2: (context) => const LevelScreen(),
    gameMemory3: (context) => const MemoryThreeScreen(),

    //Memory Game
    memoryScreen: (context) => const MemoryScreen(),
    gameLetter: (context) => const LanguagesFirstLetter(),
    gameWord: (context) => const LanguagesFirstWord(),
    gameConj: (context) => const LanguageGameThree(),
    gameSort: (context) => const WordFind(),

    // Attention Game
    game3atte1: (context) => const GameAtte3Level1(),
    game3atte2: (context) => const GameAtte3Level2(),
    game3atte3: (context) => const GameAtte3Level3(),
    game3atte4: (context) => const GameAtte3Level4(),
    game3atte5: (context) => const GameAtte3Level5(),
    game3atte6: (context) => const GameAtte3Level6(),
    game3atte7: (context) => const GameAtte3Level7(),
    game3atte8: (context) => const GameAtte3Level8(),
    game3atte9: (context) => const GameAtte3Level9(),
    game3atte10: (context) => const GameAtte3Level10(),
    // gametest: (context) => const TestAppView(),
    attentionScreen: (context) => const AttentionScreen(),
    levelattengame3: (context) => const LevelsScreen(),
    game1Atten: (context) => const AttentionGameOne(),
    game2Atten: (context) => const AttentionTwoScreen(),
    //admin

    admin_page2: (context) => const Adminpage(),
  };
}
