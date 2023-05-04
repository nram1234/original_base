import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/core/models/selectable_type.dart';
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class TypesSelector extends StatelessWidget {
  final List<int> selectedTypesIds;

  final List<SelectableType> allTypes;

  final ValueChanged<int> onAddType;
  final ValueChanged<int> onRemoveType;

  const TypesSelector({
    required this.selectedTypesIds,
    required this.allTypes,
    required this.onAddType,
    required this.onRemoveType,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: allTypes.map((type) {
        bool isSelected = selectedTypesIds.contains(type.serverId);
        return ChoiceChip(
          elevation: 0.0,
          pressElevation: 0.0,
          selectedColor: Palette.burntSienna,
          padding: const EdgeInsets.all(4.0),
          label: Text(
            type.nameId.translate(context),
            textAlign: TextAlign.center,
            style: TextStyles.caption.copyWith(
              height: 1.0,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : Palette.shuttleGray,
            ),
          ),
          selected: isSelected,
          onSelected: (_) => isSelected
              ? onRemoveType(type.serverId)
              : onAddType(type.serverId),
        );
      }).toList(),
    );
  }
}
