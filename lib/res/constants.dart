import 'package:flutter/material.dart';

InputDecoration styleTextInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  hintStyle: TextStyle(
    color: Colors.grey,
    fontSize: 18,
  ),
  contentPadding: EdgeInsets.all(10),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(
      color: Colors.blue[300],
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(
      color: Colors.blue,
    ),
  ),
);
