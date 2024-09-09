import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';

// ignore: must_be_immutable
class BottomNavbarButton extends StatelessWidget {
  List names = [
    'bottomNavBar1',
    'bottomNavBar2',
    'Gifts',
    'UC',
    'profil',
  ];
  List iconsLight = [
    IconlyLight.home,
    IconlyLight.document,
    CupertinoIcons.gift,
    IconlyLight.wallet,
    IconlyLight.profile,
  ];
  List iconsBold = [
    IconlyBold.home,
    IconlyBold.document,
    CupertinoIcons.gift,
    IconlyBold.wallet,
    IconlyBold.profile,
  ];
  final Function() onTapp;
  final int selectedIndex;
  final int index;
  final bool icon;
  BottomNavbarButton({
    required this.onTapp,
    required this.selectedIndex,
    required this.index,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapp,
      child: Column(
        children: [
          Container(
            height: 2,
            decoration: BoxDecoration(color: index == selectedIndex ? kPrimaryColor : kPrimaryColorBlack, borderRadius: BorderRadius.circular(4)),
          ),
          Expanded(
            child: AnimatedContainer(
              width: double.infinity,
              height: index == selectedIndex ? Get.size.height : 0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    index == selectedIndex ? kPrimaryColor.withOpacity(0.005) : Colors.transparent,
                    index == selectedIndex ? kPrimaryColor.withOpacity(0.3) : Colors.transparent,
                  ],
                  stops: const [0.0, 0.7],
                  begin: FractionalOffset.bottomCenter,
                  end: FractionalOffset.topCenter,
                  tileMode: TileMode.clamp,
                ),
              ),
              duration: const Duration(milliseconds: 500),
              curve: Curves.decelerate,
              child: Column(
                children: [
                  Expanded(
                      child: index != selectedIndex
                          ? Icon(
                              iconsLight[index],
                              size: 24,
                              color: Colors.white,
                            )
                          : Icon(
                              iconsBold[index],
                              size: 24,
                              color: Colors.white,
                            )),
                  Text(
                    '${names[index]}'.tr,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontFamily: index == selectedIndex ? josefinSansMedium : josefinSansRegular, fontSize: index == selectedIndex ? 13 : 12),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
