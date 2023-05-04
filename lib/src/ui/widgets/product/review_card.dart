import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/core/models/store/store_review.dart';
import 'package:original_base/src/core/utils/numeral_extensions.dart';
import 'package:original_base/src/core/utils/cached_image_util.dart';
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class ReviewCard extends StatelessWidget {
  final bool expandComment;

  final StoreReview review;

  const ReviewCard({
    this.expandComment = false,
    required this.review,
  });

  IconData get starIcon {
    bool reviewIsWholeNumber = review.rating.isWholeNumber;
    if (review.rating == 0.0) {
      return Icons.star_border;
    } else if (reviewIsWholeNumber) {
      return Icons.star;
    } else {
      return Icons.star_half;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        SharedStyles.componentsPadding,
      ),
      decoration: BoxDecoration(
        color: Palette.pattensBlue,
        borderRadius: BorderRadius.circular(
          SharedStyles.mediumComponentsRadius,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        SharedStyles.smallComponentsRadius,
                      ),
                      child: review.owner.imageUrl.isNotEmpty
                          ? getCachedImage(
                              review.owner.imageUrl,
                              height: 59.0,
                              width: 58.0,
                            )
                          : Image.asset(
                              "assets/images/default_user_image.png",
                              height: 59.0,
                              width: 58.0,
                            ),
                    ),
                    SizedBox(width: 15.0),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.owner.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.subtitle2.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 3.0),
                          Row(
                            children: [
                              Text(
                                "${review.rating}",
                                style: TextStyles.caption.copyWith(
                                  height: 1.2,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 3.0),
                              Icon(
                                starIcon,
                                color: Palette.mustard,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20.0),
              Text(
                review.dateAdded.formattedDate,
                style: TextStyles.caption.copyWith(
                  height: 1.0,
                  color: Palette.shuttleGray,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          if (review.comment.isNotEmpty) ...[
            SizedBox(height: 7.0),
            Text(
              review.comment,
              overflow: expandComment ? null : TextOverflow.ellipsis,
              maxLines: expandComment ? null : 1,
              style: TextStyles.caption,
            ),
          ],
        ],
      ),
    );
  }
}
