import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/core/utils/numeral_extensions.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final bool readOnly;

  final int _starsCount = 5;

  final double rating;
  final double starSize;

  /// amount of empty space between each star.
  final double spacing;

  final RatingChangeCallback? onRatingChanged;

  const StarRating({
    this.readOnly = false,
    this.rating = 0.0,
    this.spacing = 0.0,
    this.starSize = 24.0,
    this.onRatingChanged,
  }) : assert(onRatingChanged != null || readOnly == true);

  Icon getStar(int index, double currentRating) {
    IconData iconData;

    // check star conditions
    bool notFilled = index >= currentRating;
    bool halfFilled = index >= (currentRating - 0.5) && index < currentRating;

    // assign iconData value depending on previous conditions
    if (notFilled) {
      iconData = Icons.star_border;
    } else if (halfFilled) {
      iconData = Icons.star_half;
    } else {
      iconData = Icons.star;
    }

    return Icon(
      iconData,
      size: starSize,
      color: Palette.mustard,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ratingNotifier = ValueNotifier<double>(rating);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Material(
        color: Colors.transparent,
        child: ValueListenableBuilder(
          valueListenable: ratingNotifier,
          builder: (_, starsRating, __) {
            return Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: spacing,
              children: List.generate(_starsCount, (starIndex) {
                return GestureDetector(
                  onTap: () {
                    // ignore tap event
                    if (readOnly) return;

                    ratingNotifier.value = starIndex + 1.0;
                    if (onRatingChanged != null) {
                      onRatingChanged!(ratingNotifier.value.roundToNearestHalf);
                    }
                  },
                  onHorizontalDragUpdate: (details) {
                    // ignore tap event
                    if (readOnly) return;

                    // determine new rating value using local widget offset.
                    RenderBox? box = context.findRenderObject() as RenderBox?;
                    Offset offset = box!.globalToLocal(details.globalPosition);
                    double newRating = offset.dx / starSize;

                    // ensure that new rating value is between min and max value.
                    if (newRating > _starsCount) {
                      newRating = _starsCount.toDouble();
                    }
                    if (newRating < 0) newRating = 0.0;

                    ratingNotifier.value = newRating;
                    onRatingChanged!(newRating.roundToNearestHalf);
                  },
                  child: getStar(starIndex, ratingNotifier.value),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
