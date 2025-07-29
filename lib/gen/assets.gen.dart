/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsAnimGen {
  const $AssetsAnimGen();

  /// File path: assets/anim/splash_image_anim.json
  String get splashImageAnim => 'assets/anim/splash_image_anim.json';

  /// List of all assets
  List<String> get values => [splashImageAnim];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/calm_zone_logo.png
  AssetGenImage get calmZoneLogo =>
      const AssetGenImage('assets/images/calm_zone_logo.png');

  /// File path: assets/images/mvt-im_9.png
  AssetGenImage get mvtIm9 => const AssetGenImage('assets/images/mvt-im_9.png');

  /// File path: assets/images/mvt_im-8.PNG
  AssetGenImage get mvtIm8 => const AssetGenImage('assets/images/mvt_im-8.PNG');

  /// File path: assets/images/mvt_im_1.PNG
  AssetGenImage get mvtIm1 => const AssetGenImage('assets/images/mvt_im_1.PNG');

  /// File path: assets/images/mvt_im_2.PNG
  AssetGenImage get mvtIm2 => const AssetGenImage('assets/images/mvt_im_2.PNG');

  /// File path: assets/images/mvt_im_3.PNG
  AssetGenImage get mvtIm3 => const AssetGenImage('assets/images/mvt_im_3.PNG');

  /// File path: assets/images/mvt_im_4.PNG
  AssetGenImage get mvtIm4 => const AssetGenImage('assets/images/mvt_im_4.PNG');

  /// File path: assets/images/mvt_im_5.PNG
  AssetGenImage get mvtIm5 => const AssetGenImage('assets/images/mvt_im_5.PNG');

  /// File path: assets/images/mvt_im_6.PNG
  AssetGenImage get mvtIm6 => const AssetGenImage('assets/images/mvt_im_6.PNG');

  /// File path: assets/images/mvt_im_7.PNG
  AssetGenImage get mvtIm7 => const AssetGenImage('assets/images/mvt_im_7.PNG');

  /// List of all assets
  List<AssetGenImage> get values => [
    calmZoneLogo,
    mvtIm9,
    mvtIm8,
    mvtIm1,
    mvtIm2,
    mvtIm3,
    mvtIm4,
    mvtIm5,
    mvtIm6,
    mvtIm7,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsAnimGen anim = $AssetsAnimGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
