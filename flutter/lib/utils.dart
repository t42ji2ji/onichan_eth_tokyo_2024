import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

void okToast(String text) {
  showToast(
    text,
    position: ToastPosition.bottom,
    radius: 10.0,
    textStyle: const TextStyle(
      fontSize: 20.0,
      color: Colors.white,
    ),
  );
}
