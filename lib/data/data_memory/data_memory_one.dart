import '../../models/tile_model_one.dart';

List<TileModel> pairs = [];
List<TileModel> pairsBlue = [];
List<TileModel> pairsWhite = [];
List<TileModel> visiblePairs = [];
List<TileModel> result = [];
bool selected = false;

// Lưu trữ Images đã chọn
String selectedImageAssetPath = '';
int selectedTileIndex = 0;

// Số vòng chơi Round
int tries = 1;

int total = 0;
int score = 0;

int timeLeft = 0;

int numOfChoose = 0;
int numOfCorrect = 0;
int error = 0;
int numOfWrong = 0;
int level = 1;
int maxLevel = 0;

// store result
List<int> indexResult = [];

// Lưu index các hình đã được chọn
List<int> store = [];

// Pick Img random
List<T> pickRandomItemsAsListWithSubList<T>(List<T> items, int count) =>
    (items.toList()..shuffle()).sublist(0, count);

List<TileModel> getResult() {
  List<TileModel> pairs2 = [
    TileModel(imageAssetPath: "assets/red.png", isSelected: false)
  ];
  return pairs2;
}

// 101
List<TileModel> getWhite() {
  List<TileModel> pairs2 = [
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/white.png",
      isSelected: false,
    ),
  ];
  return pairs2;
}

// 102
List<TileModel> getBlue() {
  List<TileModel> pairs2 = [
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
    TileModel(
      imageAssetPath: "assets/blue.png",
      isSelected: false,
    ),
  ];
  return pairs2;
}
