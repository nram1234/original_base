import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/ui/responsive_layout/size_extension.dart';
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class ProductDetailsCard extends StatelessWidget {
  final bool showQuantity;

  final int quantity;

  final String partCondition;
  final String guaranteePeriod;
  final String guaranteeCompany;
  final String countryOfOrigin;

  const ProductDetailsCard({
    this.showQuantity = false,
    required this.quantity,
    required this.partCondition,
    required this.guaranteePeriod,
    required this.guaranteeCompany,
    required this.countryOfOrigin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        SharedStyles.componentsPadding,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Palette.pattensBlue,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(
          SharedStyles.smallComponentsRadius,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _InfoRow(
            titleId: "#part_condition",
            value: partCondition,
          ),
          Divider(color: Palette.linkWater),
          _InfoRow(
            titleId: "#country_of_origin",
            value: countryOfOrigin,
          ),
          Divider(color: Palette.linkWater),
          _InfoRow(
            titleId: "#warranty_company",
            value: guaranteeCompany,
          ),
          if (guaranteePeriod.isNotEmpty) ...[
            Divider(color: Palette.linkWater),
            _InfoRow(
              titleId: "#guarantee_period",
              value: guaranteePeriod,
            ),
          ],
          if (showQuantity) ...[
            Divider(color: Palette.linkWater),
            _InfoRow(
              titleId: "#stock",
              value: "$quantity " + "#part".translate(context).toLowerCase(),
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  /// id used to translate title.
  final String titleId;
  final String value;

  const _InfoRow({
    required this.titleId,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 74.0.w,
          child: Text(
            titleId.translate(context),
            style: TextStyles.caption.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Text(value, style: TextStyles.caption),
      ],
    );
  }
}
