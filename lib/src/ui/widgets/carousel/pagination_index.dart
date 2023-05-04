import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class PaginationIndex extends StatelessWidget {
  final int numberOfItems;
  final int activeIndex;

  const PaginationIndex({
    required this.numberOfItems,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          numberOfItems,
          // i + 1 returns the index number by human count.
          (i) => Dot(active: i + 1 == activeIndex),
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final bool active;

  const Dot({required this.active});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          color: active ? Palette.burntSienna : Palette.cinderella,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
