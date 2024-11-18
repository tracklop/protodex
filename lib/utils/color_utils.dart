import 'package:flutter/material.dart';

Color getColorForType(String type) {
  switch (type) {
    case 'fire':
      return const Color(0xfff29879);
    case 'water':
      return const Color(0xff89c1f2);
    case 'grass':
      return const Color(0xff88c590);
    case 'electric':
      return const Color(0xfff7d269);
    case 'psychic':
      return const Color(0xffe49ac3);
    case 'ice':
      return const Color(0xff9ed2f4);
    case 'dragon':
      return const Color(0xff7faacb);
    case 'dark':
      return const Color(0xff888b98);
    case 'fairy':
      return const Color(0xffeea5ce);
    case 'steel':
      return const Color(0xffb8c4d1);
    case 'ghost':
      return const Color(0xff9889cc);
    case 'poison':
      return const Color(0xffab8fc7);
    case 'flying':
      return const Color(0xff92bed4);
    case 'ground':
      return const Color(0xffd6b28b);
    case 'bug':
      return const Color(0xffa3c97f);
    case 'rock':
      return const Color(0xffc1a385);
    case 'normal':
      return const Color(0xffcfc5a8);
    default:
      return Colors.grey;
  }
}
