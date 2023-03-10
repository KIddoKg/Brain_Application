import '../../models/tile_model_one.dart';

bool selected = false;
// List of source
List<TileModel> pairs = [];
// List chứa 3 Img đầu tiên
List<TileModel> getImg = [];
// List còn lại sau khi lấy 3 Img
List<TileModel> remain = [];

List selectedImageAssetPath = [];

List<int> indicesOfRemain = [];
List<int> indices = [];
List<int> borderIndexes = [];

// Lưu trữ Images đã chọn
int selectedTileIndex = -1;

int score = 0;
int bonus = 0;
// int level = 1;
int tries = 1; // Lượt chơi 3
int numOfCard = 0;
int numOfCard_1 = 0;
int numOfCard_2 = 0;
int numOfCard_3 = 0;

// Pick Img random
List<T> pickRandomItemsAsListWithSubList<T>(List<T> items, int count) =>
    (items.toList()..shuffle()).sublist(0, count);

// Use check item exists
var checkString;

// var listOfList = [getAnimal(), getPairs_2(), getPairs_3(), getPairs_4()];

var listOfEasy = [getAnimal(), getFruit(), getHousehold()];
var listOfMedium = [getTrans(), getLogo()];

// * Animal/Easy
List<TileModel> getAnimal() {
  List<TileModel> pairs = [
    TileModel(imageAssetPath: 'assets/Animal/1.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/2.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/3.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/4.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/5.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/6.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/7.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/8.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/9.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/10.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/11.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/12.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/13.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/14.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/15.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/16.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/17.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/18.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/19.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/20.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/21.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/22.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/23.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/24.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/25.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/26.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/27.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/28.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/29.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/30.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/31.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/32.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/33.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/34.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/35.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/36.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/37.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/38.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/39.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/40.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/41.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/42.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/43.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/44.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/45.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/46.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/47.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/48.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/49.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/50.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/51.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/52.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/53.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/54.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/55.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/56.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/57.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/58.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/59.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/60.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/61.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/62.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/63.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/64.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/65.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/66.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/67.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/68.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/69.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/70.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/71.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/72.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/73.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/74.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/75.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/76.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/77.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/78.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/79.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Animal/80.jpg', isSelected: false),
  ];
  return pairs;
}

// * Fruit/Easy
List<TileModel> getFruit() {
  List<TileModel> pairs = [
    TileModel(imageAssetPath: 'assets/Fruit/1.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/2.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/3.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/4.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/5.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/6.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/7.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/8.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/9.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/10.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/11.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/12.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/13.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/14.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/15.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/16.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/17.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/18.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/19.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/20.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/21.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/22.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/23.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/24.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/25.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/26.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/27.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/28.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/29.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/30.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/31.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/32.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/33.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/34.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/35.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/36.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/37.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/38.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/39.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/40.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/41.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/42.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/43.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/44.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/45.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/46.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/47.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/48.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/49.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/50.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/51.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/52.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/53.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/54.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/55.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/56.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/57.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/58.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/59.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/60.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/61.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/62.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/63.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/64.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/65.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/66.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/67.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/68.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/69.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/70.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/71.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/72.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/73.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/74.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/75.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/76.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/77.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/78.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/79.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Fruit/80.jpg', isSelected: false),
  ];
  return pairs;
}

// * Household/Easy
List<TileModel> getHousehold() {
  List<TileModel> pairs = [
    TileModel(imageAssetPath: 'assets/Household/1.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/2.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/3.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/4.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/5.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/6.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/7.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/8.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/9.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/10.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/11.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/12.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/13.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/14.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/15.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/16.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/17.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/18.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/19.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/20.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/21.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/22.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/23.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/24.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/25.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/26.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/27.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/28.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/29.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/30.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/31.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/32.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/33.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/34.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/35.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/36.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/37.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/38.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/39.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/40.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/41.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/42.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/43.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/44.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/45.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/46.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/47.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/48.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/49.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/50.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/51.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/52.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/53.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/54.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/55.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/56.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/57.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/58.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/59.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/60.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/61.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/62.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/63.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/64.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/65.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/66.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/67.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/68.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/69.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/70.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/71.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/72.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/73.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/74.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/75.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/76.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/77.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/78.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/79.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/80.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/81.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/82.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/83.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/84.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Household/85.jpg', isSelected: false),
  ];
  return pairs;
}

// * Transportation/Medium
List<TileModel> getTrans() {
  List<TileModel> pairs = [
    TileModel(imageAssetPath: 'assets/Transportation/1.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Transportation/2.png', isSelected: false),
    TileModel(imageAssetPath: 'assets/Transportation/3.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Transportation/4.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Transportation/5.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Transportation/6.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Transportation/7.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Transportation/8.jpg', isSelected: false),
    TileModel(imageAssetPath: 'assets/Transportation/9.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/10.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/11.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/12.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/13.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/14.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/15.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/16.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/17.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/18.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/19.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/20.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/21.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/22.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/23.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/24.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/25.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/26.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/27.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/28.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/29.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/30.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/31.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/32.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/33.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/34.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/35.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/36.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/37.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/38.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/39.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/40.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/41.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/42.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/43.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/44.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/45.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/46.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/47.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/48.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/49.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/50.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/51.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/52.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/53.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/54.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/55.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/56.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/57.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/58.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/59.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/60.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/61.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/62.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/63.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/64.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/65.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/66.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/67.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/68.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/69.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/70.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/71.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/72.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/73.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/74.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/75.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/76.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/77.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/78.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/79.jpg', isSelected: false),
    TileModel(
        imageAssetPath: 'assets/Transportation/80.jpg', isSelected: false),
  ];
  return pairs;
}

// * Logo/Medium
List<TileModel> getLogo() {
  List<TileModel> pairs = [
    TileModel(imageAssetPath: "assets/Logo/1.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/2.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/3.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/4.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/5.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/6.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/7.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/8.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/9.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/10.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/11.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/12.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/13.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/14.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/15.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/16.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/17.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/18.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/19.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/20.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/21.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/22.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/23.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/24.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/25.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/26.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/27.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Logo/28.jpg", isSelected: false),
  ];
  return pairs;
}

// * Shape/Hard
List<TileModel> getShape() {
  List<TileModel> pairs = [
    TileModel(imageAssetPath: "assets/Shape/1.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/2.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/3.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/4.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/5.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/6.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/7.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/8.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/9.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/10.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/11.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/12.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/13.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/14.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/15.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/16.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/17.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/18.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/19.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/20.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/21.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/22.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/23.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/24.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/25.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/26.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/27.jpg", isSelected: false),
    TileModel(imageAssetPath: "assets/Shape/28.jpg", isSelected: false),
  ];
  return pairs;
}
