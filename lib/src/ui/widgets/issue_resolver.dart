import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class IssueResolver extends StatelessWidget {
  final bool disabled;

  final String problem;
  final String solution;

  final VoidCallback onResolve;

  const IssueResolver({
    this.disabled = false,
    required this.problem,
    required this.solution,
    required this.onResolve,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          problem,
          style: TextStyles.body2.copyWith(
            color: Palette.charcoal,
          ),
        ),
        Material(
          color: Colors.transparent,
          child: IgnorePointer(
            ignoring: disabled,
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  solution,
                  style: TextStyles.body2.copyWith(
                    fontWeight: FontWeight.w500,
                    color: disabled ? Palette.shuttleGray : Palette.burntSienna,
                  ),
                ),
              ),
              onTap: onResolve,
            ),
          ),
        ),
      ],
    );
  }
}
