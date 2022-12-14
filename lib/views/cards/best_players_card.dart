import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../constants/widgets.dart';

class BestPlayersCard extends StatelessWidget {
  final String points;
  final String name;
  final int index;
  final bool referalPage;
  const BestPlayersCard({super.key, required this.name, required this.index, required this.points, required this.referalPage});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showSnackBar('Icine girmek', 'Akkaunt Satlyga cykaran ulanyjylara girip bolyar galanyna Ustune bassan girip bolmayar etmeli', Colors.green);
      },
      dense: true,
      tileColor: index % 2 == 0 ? kPrimaryColorBlack1 : kPrimaryColorBlack,
      minVerticalPadding: 15,
      contentPadding: EdgeInsets.zero,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              ' ${index + 1}.',
              textAlign: referalPage ? TextAlign.center : TextAlign.start,
              style: const TextStyle(color: Colors.white, fontFamily: josefinSansBold, fontSize: 20),
            ),
          ),
          referalPage
              ? const SizedBox.shrink()
              : Expanded(
                  flex: 3,
                  child: ClipOval(
                    child: SizedBox(
                      width: 60,
                      height: 70,
                      child: Image.asset(
                        'assets/bestPlayersProfil/${index + 1}.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
          Expanded(
            flex: 9,
            child: Text(
              '  $name',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 20),
            ),
          ),
          Expanded(
            flex: 3,
            child: referalPage
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        points,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: josefinSansSemiBold,
                        ),
                      ),
                      const Text(
                        ' TMT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: josefinSansSemiBold,
                        ),
                      ),
                    ],
                  )
                : Text(
                    points,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.end,
                    style: const TextStyle(color: Colors.white, fontFamily: josefinSansSemiBold, fontSize: 20),
                  ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
