import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//----------------------------------------------
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

enum ContactMethod { phone, email, website }

class ContactInfo extends StatelessWidget {
  final String title;
  final String contactValue;

  final ContactMethod method;

  const ContactInfo({
    required this.title,
    required this.contactValue,
    required this.method,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: SharedStyles.componentsPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "$title :",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.subtitle2.copyWith(
              height: 1.0,
              fontWeight: FontWeight.w700,
              color: Palette.bigStone,
            ),
          ),
          SizedBox(width: 10.0),
          Flexible(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                child: Container(
                  child: Text(
                    contactValue,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.body1.copyWith(
                      height: 1.0,
                      color: Palette.bigStone,
                    ),
                  ),
                ),
                onTap: () {
                  late String prefix;
                  if (method == ContactMethod.email) {
                    prefix = "mailto:";
                  } else if (method == ContactMethod.phone) {
                    prefix = "tel:";
                  } else {
                    prefix = "https://";
                  }

                  launch("$prefix$contactValue");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
