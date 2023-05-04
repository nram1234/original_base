import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/config/app_theme.dart';
//-------------------------------------------------------

class DialogScaffold extends StatelessWidget {
  final double height;

  final List<Widget> children;

  const DialogScaffold({
    required this.height,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: this.height,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SharedStyles.componentsPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25.0),
              ...this.children,
            ],
          ),
        ),
      ),
    );
  }
}
