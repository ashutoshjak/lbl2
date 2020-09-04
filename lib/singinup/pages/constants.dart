import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white12,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0XFFF59C16), width: 4.0),
    borderRadius: const BorderRadius.all(
      const Radius.circular(100.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.redAccent, width: 4.0),
    borderRadius: const BorderRadius.all(
      const Radius.circular(100.0),
    ),
  ),
);
