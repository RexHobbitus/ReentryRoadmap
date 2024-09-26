import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/utils/constants.dart';

class CustomCachedImage extends StatelessWidget {
  final String? imgUrl;
  final double width;
  final double height;
  final double? radius;
  final BorderRadius? borderRadius;

  const CustomCachedImage({
    super.key,
    this.imgUrl="",
    this.width=100,
    this.height=100,
    this.radius,
    this.borderRadius});



  @override
  Widget build(BuildContext context) {
    if (imgUrl==null || imgUrl!.isEmpty) {
      return Icon(Icons.image_outlined,size: height,);
    }
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 0),
      child: CachedNetworkImage(
        imageUrl: imgUrl??kPlaceHolderImage,
        height: height,
        width: width,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (child, url,downloadProgress) =>Icon(Icons.image_outlined,size: height,),
        errorWidget: (child, url,obj) => Icon(Icons.error_outline,size: height,),
      ),
    );
  }
}