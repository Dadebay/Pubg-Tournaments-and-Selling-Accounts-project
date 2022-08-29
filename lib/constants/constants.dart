import 'package:flutter/material.dart';

const int userID = 2;

const String serverURL = "http://95.85.125.234:8800";
// const String serverURL = "http://192.168.31.68:8800";
// const String serverImage = "https://elyeter.market";
// const String authServerUrl = "https://elyeter.market";

const Color backgroundColor = Color(0xfff2f2f2);
const Color kPrimaryColor = Color(0xFFFF9800);
const Color kPrimaryColorBlack = Color(0xff161621);
const Color kPrimaryColorBlack1 = Color.fromARGB(255, 37, 42, 51);

Map<int, Color> color = {
  50: const Color.fromRGBO(255, 92, 87, .1),
  100: const Color.fromRGBO(255, 92, 87, .2),
  200: const Color.fromRGBO(255, 92, 87, .3),
  300: const Color.fromRGBO(255, 92, 87, .4),
  400: const Color.fromRGBO(255, 92, 87, .5),
  500: const Color.fromRGBO(255, 92, 87, .6),
  600: const Color.fromRGBO(255, 92, 87, .7),
  700: const Color.fromRGBO(255, 92, 87, .8),
  800: const Color.fromRGBO(255, 92, 87, .9),
  900: const Color.fromRGBO(255, 92, 87, 1),
};

MaterialColor colorCustom = MaterialColor(0xff55b539, color);

///BorderRadius
const BorderRadius borderRadius5 = BorderRadius.all(Radius.circular(5));
const BorderRadius borderRadius10 = BorderRadius.all(Radius.circular(10));
const BorderRadius borderRadius15 = BorderRadius.all(Radius.circular(15));
const BorderRadius borderRadius20 = BorderRadius.all(Radius.circular(20));
const BorderRadius borderRadius25 = BorderRadius.all(Radius.circular(25));
const BorderRadius borderRadius30 = BorderRadius.all(Radius.circular(30));
/////////////////////////////////
const String josefinSansRegular = "JosefinSansRegular";
const String josefinSansMedium = "JosefinSansMedium";
const String josefinSansSemiBold = "JosefinSansSemiBold";
const String josefinSansBold = "JosefinSansBold";
//Language icons
const String tmIcon = "assets/lang/tm.png";
const String ruIcon = "assets/lang/ru.png";
const String account_back_image = "assets/images/banner/3.png";
const String loremImpsum =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum";
//App Name

List sortData = [
  {
    "id": 1,
    "name": "sortDefault",
    "sort_column": "price",
    "sort_direction": "",
  },
  {
    "id": 2,
    "name": "sortPriceLowToHigh",
    "sort_column": "price",
    "sort_direction": "high",
  },
  {
    "id": 3,
    "name": "sortPriceHighToLow",
    "sort_column": "price",
    "sort_direction": "low",
  },
  {
    "id": 4,
    "name": "sortCreatedAtHighToLow",
    "sort_column": "date",
    "sort_direction": "new",
  },
  {
    "id": 5,
    "name": "sortCreatedAtLowToHigh",
    "sort_column": "date",
    "sort_direction": "old",
  },
];
