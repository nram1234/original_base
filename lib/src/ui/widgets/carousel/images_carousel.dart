import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
//----------------------------------------------------
import 'package:original_base/src/core/services/shared/sailor_navigation_service.dart';
import 'package:original_base/src/ui/widgets/product/product_images_viewer.dart';
import 'package:original_base/src/core/utils/cached_image_util.dart';
import 'package:original_base/src/core/models/home_banner.dart';
import 'package:original_base/src/config/app_theme.dart';
//-------------------------------------------------------

class ImagesCarousel extends StatelessWidget {
  final bool infiniteScroll;
  final bool autoPlay;

  /// The ratio between width of shown image and the next and previous one.
  final double viewportFraction;

  final double horizontalPadding;
  final double borderRadius;
  final double height;

  /// name of product if this carousel used to show product images.
  final String? productName;

  /// images urls.
  final List<String> urls;

  /// a list that contains banners data
  /// if this image carousel is used for home banners.
  final List<HomeBanner>? bannersData;

  /// callback function executed whenever the current shown image is changed.
  final Function(int index, CarouselPageChangedReason reason)? onPageChanged;

  const ImagesCarousel({
    this.infiniteScroll = false,
    this.autoPlay = false,
    this.viewportFraction = 0.8,
    this.horizontalPadding = 0.0,
    this.borderRadius = SharedStyles.mediumComponentsRadius,
    required this.height,
    this.productName,
    required this.urls,
    this.bannersData,
    this.onPageChanged,
  }) : assert(urls.length == bannersData?.length || bannersData == null);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        for (int i = 0; i < urls.length; i++)
          GestureDetector(
            onTap: () => _handleOnImageTap(i),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: SizedBox.expand(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: getCachedImage(
                    urls[i],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
      ],
      options: CarouselOptions(
        autoPlay: autoPlay,
        autoPlayInterval: const Duration(seconds: 5),
        height: height,
        viewportFraction: viewportFraction,
        enableInfiniteScroll: infiniteScroll,
        onPageChanged: onPageChanged,
      ),
    );
  }

  void _handleOnImageTap(int imageIndex) {
    if (bannersData != null) {
      Sailor.toNamed(
        "dashboard/home_banner",
        args: {"data": bannersData![imageIndex]},
      );
    } else if (productName != null) {
      Sailor.to(
        ProductImagesViewer(
          initialIndex: imageIndex,
          productName: productName!,
          imagesUrls: urls,
        ),
      );
    }
  }
}
