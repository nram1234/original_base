import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//--------------------------------------------
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/ui/widgets/product/product_status_badge.dart';
import 'package:original_base/src/core/utils/time_ago_util.dart';
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class ProductSummary extends StatelessWidget {
  final bool availableInStock;
  final bool usedProduct;

  final int? discount;

  final double price;
  final double rating;
  final double? priceBeforeDiscount;

  final String productName;

  final DateTime createTime;

  ProductSummary({
    required this.availableInStock,
    required this.usedProduct,
    this.discount,
    required this.price,
    required this.rating,
    this.priceBeforeDiscount,
    required this.productName,
    required this.createTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        SharedStyles.componentsPadding,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          SharedStyles.mediumComponentsRadius,
        ),
        color: Palette.pattensBlue,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$price " + "#LE".translate(context),
                style: TextStyles.title.copyWith(
                  color: Palette.shuttleGray,
                  fontFamily: FontFamilies.almarai,
                ),
              ),
              Row(
                children: [
                  Text(
                    TimeAgoUtil().formatTime(createTime, context.langCode),
                    style: TextStyles.caption.copyWith(
                      height: 1.0,
                      color: Palette.spunPearl,
                    ),
                  ),
                  SizedBox(width: 7.0),
                  SizedBox(
                    height: 18.0,
                    width: 18.0,
                    child: SvgPicture.asset(
                      "assets/icons/time.svg",
                      color: Palette.spunPearl,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: SharedStyles.componentsPadding),
          if (discount != null && discount != 0) ...[
            Row(
              children: [
                Text(
                  "#instead_of".translate(context),
                  style: TextStyles.caption.copyWith(
                    color: Palette.dimGray,
                    fontFamily: FontFamilies.almarai,
                  ),
                ),
                SizedBox(width: 5.0),
                Text(
                  "$priceBeforeDiscount " + "#LE".translate(context),
                  style: TextStyles.caption.copyWith(
                    fontFamily: FontFamilies.almarai,
                    fontWeight: FontWeight.w700,
                    color: Palette.burntSienna,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
          ],
          Text(
            productName,
            style: TextStyles.body2.copyWith(
              height: 1.0,
              color: Palette.burntSienna,
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              if (discount != null && discount != 0) ...[
                ProductStatusBadge(
                  status: "$discount% " + "#discount".translate(context),
                ),
                SizedBox(width: 7.0),
              ],
              ProductStatusBadge(
                status: availableInStock
                    ? "#available_in_stock".translate(context)
                    : "#out_of_stock".translate(context),
              ),
              SizedBox(width: 7.0),
              ProductStatusBadge(
                status: usedProduct
                    ? "#used".translate(context)
                    : "#new".translate(context),
              ),
              SizedBox(width: 11.0),
              Row(
                children: [
                  Text(
                    "$rating",
                    style: TextStyles.caption.copyWith(
                      height: 1.0,
                      color: Palette.shuttleGray,
                    ),
                  ),
                  SizedBox(width: 1.0),
                  Icon(
                    Icons.star,
                    color: Palette.mustard,
                    size: 20.0,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
