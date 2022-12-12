// ignore_for_file: file_names

import 'package:game_app/views/constants/constants.dart';
import 'package:flutter/material.dart';

class Price extends StatelessWidget {
  final bool showDiscountedPrice;
  final String price;
  final String? discountedPrice;
  const Price({
    required this.showDiscountedPrice,
    required this.price,
    Key? key,
    this.discountedPrice,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: showDiscountedPrice ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Text(
          price,
          style: TextStyle(
            color: showDiscountedPrice ? Colors.white : kPrimaryColor,
            fontSize: size.width >= 800 ? 27 : 23,
            fontFamily: josefinSansSemiBold,
          ),
        ),
        Text(
          ' TMT',
          style: TextStyle(
            color: showDiscountedPrice ? Colors.white : kPrimaryColor,
            fontSize: size.width >= 800 ? 20 : 14,
            fontFamily: josefinSansSemiBold,
          ),
        ),
      ],
    );
  }
}
