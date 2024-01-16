import 'package:flutter/material.dart';

const kButtonShare = Color(0xFFB4B8C2);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kPrimaryColor = Color(0xFFE09090);
const kSecondaryColor = Color(0xFFC78080);
const kTextColor = Colors.white;
const kTextDescription = Color(0xFF8A8A8A);
const kIconsShare = Color(0xFF515357);
const kAnimationDuration = Duration(milliseconds: 200);

const headingStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 16),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: kTextColor),
  );
}

/// ** Artigos
const Color titleColor = Color(0xFF8B8F99);
const Color textColor = Color(0xFF868A94);
const Color buttonIconColor = Color(0xFF515357);
const Color buttonTextColor = Color(0xFF515357);
const Color buttonBackgroundColor = kButtonShare;
