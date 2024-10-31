import 'package:flutter/material.dart';

Color getColorForType(String type) {
  switch (type) {
    case 'fire':
      return Color(0xfff29879);
    case 'water':
      return Color(0xff89c1f2);
    case 'grass':
      return Color(0xff88c590);
    case 'electric':
      return Color(0xfff7d269);
    case 'psychic':
      return Color(0xffe49ac3);
    case 'ice':
      return Color(0xff9ed2f4);
    case 'dragon':
      return Color(0xff7faacb);
    case 'dark':
      return Color(0xff888b98);
    case 'fairy':
      return Color(0xffeea5ce);
    case 'steel':
      return Color(0xffb8c4d1);
    case 'ghost':
      return Color(0xff9889cc);
    case 'poison':
      return Color(0xffab8fc7);
    case 'flying':
      return Color(0xff92bed4);
    case 'ground':
      return Color(0xffd6b28b);
    case 'bug':
      return Color(0xffa3c97f);
    case 'rock':
      return Color(0xffc1a385);
    case 'normal':
      return Color(0xffcfc5a8);
    default:
      return Colors.grey;
  }
}
