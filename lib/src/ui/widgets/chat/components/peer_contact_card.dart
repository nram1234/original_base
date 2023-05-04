import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
//----------------------------------------------
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/ui/widgets/buttons/action_button.dart';
import 'package:original_base/src/core/utils/cached_image_util.dart';
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/core/models/user.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class PeerContactCard extends StatelessWidget {
  final User peerData;

  const PeerContactCard(this.peerData);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 98.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          SharedStyles.mediumComponentsRadius,
        ),
        color: Palette.solitude,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SharedStyles.componentsPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      SharedStyles.mediumComponentsRadius,
                    ),
                    child: SizedBox(
                      width: 72.0,
                      height: 72.0,
                      child: peerData.imageUrl.isNotEmpty
                          ? getCachedImage(peerData.imageUrl)
                          : Image.asset("assets/images/default_user_image.png"),
                    ),
                  ),
                  SizedBox(width: 15.0),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            peerData.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.subtitle2.copyWith(
                              color: Palette.bigStone,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Flexible(
                          child: Text(
                            peerData.address,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: SharedStyles.componentsPadding),
            ActionButton(
              buttonHeight: 36.0,
              buttonWidth: 39.0,
              buttonColor: Palette.mantis,
              icon: SvgPicture.asset(
                "assets/icons/call_icon.svg",
                color: Colors.white,
              ),
              onAction: () {
                if (peerData.phoneNumber.isNotEmpty) {
                  launch("tel:${peerData.phoneNumber}");
                } else {
                  Fluttertoast.showToast(
                    msg: "#person_has_no_phone_number".translate(context),
                    toastLength: Toast.LENGTH_LONG,
                    timeInSecForIosWeb: 5,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
