import 'package:flutter/material.dart';

//Put frequently used elements here so as to avoid repetition

final pageGradient = LinearGradient(
  colors: [
    const Color.fromRGBO(225, 218, 230, 1).withOpacity(0.5),
    const Color.fromRGBO(246, 196, 237, 1).withOpacity(0.9),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: const [0, 1],
);