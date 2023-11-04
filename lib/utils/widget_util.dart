import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constants.dart';

TextStyle getCustomTextStyle(double? txtSize, Color? txtColor, {String? fontFamily,List<Shadow>? shadow,FontWeight? weight}) {
  return TextStyle(fontSize: txtSize, color: txtColor,fontFamily:fontFamily,
      fontWeight: weight,
      shadows: shadow,decoration: TextDecoration.none);
}

Color getColors(int i) {
  if (i % 5 == 1) {
    return const Color(0xff3678fa);
  } else if (i % 5 == 2) {
    return const Color(0xffe3710d);
  } else if (i % 5 == 3) {
    return const Color(0xffc533c2);
  } else if (i % 5 == 4) {
    return const Color(0xff6054be);
  }
  return const Color(0xff16930a);
}

Widget getCustomText(String txt,
    {double? txtSize, Color? txtColor, TextAlign? txtAlign, String? fonts,List<Shadow>? shadow}) {
  return Text(
    txt,
    style: getCustomTextStyle(txtSize, txtColor,fontFamily: fonts,shadow: shadow),
    textAlign: txtAlign,
  );
}

double getButtonHeight()
{
  return 45.h;
}

Widget getAssetImage(String txt, {double? width, double? height, BoxFit? fit}) {
  return Image.asset(
    assetImagePath + txt,
    width: width,
    height: height,
    fit: fit,
  );
}

void initScreenSize(BuildContext context) {
  ScreenUtil.init(context, designSize: const Size(360, 690));
}
