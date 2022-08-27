// ignore_for_file: file_names

import 'package:game_app/constants/constants.dart';
import 'package:flutter/material.dart';

class Price extends StatelessWidget {
  final bool showDiscountedPrice;
  final String price;
  final String? discountedPrice;
  const Price({
    Key? key,
    required this.showDiscountedPrice,
    required this.price,
    this.discountedPrice,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(price,
            style: const TextStyle(
              color: kPrimaryColor,
              fontSize: 23,
              fontFamily: josefinSansSemiBold,
            )),
        const Text(" TMT",
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 14,
              fontFamily: josefinSansSemiBold,
            )),
      ],
    );
  }
}
