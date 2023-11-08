import 'package:flutter/material.dart';

InputDecoration textInputDecoration(label) {
  return InputDecoration(
    labelText: label,
    fillColor: Colors.white,
    filled: true,
    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color:  Colors.green,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.white,
      ),
    ),
  );
}

ButtonStyle buttonStyle() {
  return ElevatedButton.styleFrom(
    // backgroundColor: Colors.green,
    minimumSize: const Size(double.infinity, 45),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
