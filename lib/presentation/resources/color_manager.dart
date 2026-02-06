import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class ColorManager {
  static Color mainBlack = fromHex('#1F2029');
  static Color secondaryBlack= fromHex('#797979');
  static Color primaryWithOpacity = const Color(0x88FFFFFF);
  static Color darkGrey = const Color(0xff525252);
  static Color grey = fromHex('#EDEDED');
  static Color lightGrey = const Color(0xFFF5F5F5);
  static Color darkWhite = const Color(0x66FFFFFF);
  static Color primary22 = fromHex('#AAde5206');
  static Color black = const Color(0xff000000);
  static Color blackLight = fromHex('#797979');
  static Color yellow = const Color(0xffFFA300);
  static Color borderColor = fromHex("#E5E5E5");
  static Color yellowWithOpacity = const Color(0x88FFA300);
  static Color backGroundColor = const Color(0xFFF5F5F5);
  // new colors
  static Color darkPrimary = const Color(0xffFFFFFF);
  static Color lightPrimary = const Color(0xCCFFFFFF); // color with 80% opacity
  static Color grey1 = const Color(0xffF2F2F2);
  static Color grey2 = const Color(0xff797979);
  static Color white = const Color(0xffFFFFFF);
  static Color error = const Color(0xffe61f34); // red color
  static Color bluegray50 = fromHex('#f1f1f1');

  static Color blueA400 = fromHex('#3774e9');

  static Color primaryAb = fromHex('#abef8653');

  static Color blueA200 = fromHex('#4184e8');

  static Color bluegray50033 = fromHex('#336d8295');

  static Color whiteA700Ab = fromHex('#abffffff');

  static Color blueA20063 = fromHex('#634184e8');

  static Color red4004c = fromHex('#4ccd5858');

  static Color primary63 = fromHex('#63ef8653');

  static Color amber90063 = fromHex('#63ff7400');

  static Color redA700 = fromHex('#ff0000');

  static Color gray600 = fromHex('#887a7a');

  static Color amber900 = fromHex('#ff7400');

  static Color gray403 = fromHex('#b5b5b5');

  static Color gray400 = fromHex('#c4c4c4');

  static Color gray401 = fromHex('#beb8b8');

  static Color gray800 = fromHex('#5b4c41');

  static Color redA200 = fromHex('#ff5151');

  static Color gray7007e = fromHex('#7e725a49');

  static Color whiteA700 = fromHex('#ffffff');

  static Color amber90075 = fromHex('#75ff7400');

  static Color deepOrangeA200 = fromHex('#ff7229');

  static Color gray511 = fromHex('#b2aba6');

  static Color gray4006c = fromHex('#6cb5b5b5');

  static Color green801 = fromHex('#278e30');

  static Color green800 = fromHex('#268e30');

  static Color primary6c = fromHex('#6cef8653');

  static Color amber9006c = fromHex('#6cff7400');

  static Color red100 = fromHex('#ffc8c8');

  static Color gray80063 = fromHex('#635b4c41');

  static Color whiteA70075 = fromHex('#75ffffff');

  static Color black900 = fromHex('#000000');

  static Color yellow900 = fromHex('#fd8826');

  static Color gray40075 = fromHex('#75b5b5b5');

  static Color gray700Ab = fromHex('#ab725a49');

  static Color gray301 = fromHex('#dfdddd');

  static Color black900A2 = fromHex('#a2110801');

  static Color gray500 = fromHex('#a4a2a2');

  static Color primary= fromHex('#de5206');
  static Color lightPrimaryBackGround= fromHex('#E5E5E5');
  static Color seperatorColor = fromHex('#DEDEDE');
  static Color orange30075 = fromHex('#75ffaa50');

  static Color orange305 = fromHex('#ffab51');

  static Color gray101 = fromHex('#f6f4f2');

  static Color orange300 = fromHex('#fea057');

  static Color gray300 = fromHex('#dddddd');

  static Color gray102 = fromHex('#f8f6f4');

  static Color gray100 = fromHex('#ffffff');
  static Color titleColor = fromHex('#262626');

  static Color orange30076 = fromHex('#75ffab51');

  static Color whiteA70000 = fromHex('#00ffffff');

  static Color gray40063 = fromHex('#63c4c4c4');

  static Color gray40064 = fromHex('#63b5b5b5');

  static var circlebg= fromHex('#F1F1F1');

  static var redNotification=fromHex('#FC0101');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
