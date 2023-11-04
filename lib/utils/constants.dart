import 'package:flutter/material.dart';

var assetImagePath="assets/images/";
var scratchFontFamily="BAD-GRUNGE";


class ScratchPoint {
  ScratchPoint(this.position, this.size);

  // Null position is dedicated for point which closes the continuous drawing
  final Offset? position;
  final double size;
}
