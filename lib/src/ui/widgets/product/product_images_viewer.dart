import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/ui/widgets/carousel/pagination_index.dart';
import 'package:original_base/src/ui/widgets/layout/screen_header.dart';
import 'package:original_base/src/core/utils/cached_image_util.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class ProductImagesViewer extends StatelessWidget {
  final int initialIndex;

  final String productName;

  final List<String> imagesUrls;

  final _viewerIndexNotifier = ValueNotifier<int>(1);

  ProductImagesViewer({
    this.initialIndex = 0,
    required this.productName,
    required this.imagesUrls,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ScreenHeader(title: productName),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ValueListenableBuilder<int>(
                valueListenable: _viewerIndexNotifier,
                builder: (_, viewerIndex, __) {
                  return PaginationIndex(
                    numberOfItems: imagesUrls.length,
                    activeIndex: viewerIndex,
                  );
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1.0,
              color: Palette.bigStone,
            ),
            Expanded(
              child: PageView.builder(
                onPageChanged: (int i) {
                  _viewerIndexNotifier.value = i + 1;
                },
                itemCount: imagesUrls.length,
                controller: PageController(
                  initialPage: initialIndex,
                  keepPage: false,
                ),
                itemBuilder: (_, int i) {
                  return InteractiveViewer(
                    child: getCachedImage(imagesUrls[i]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
