import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const Map<String, TextInputType> typeMap = {
  'text': TextInputType.text,
  'number': TextInputType.number,
};

launchURL(String url) async {
  try {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } catch (e) {
    throw e.toString();
  }
}

const double cardAspectRatio = 0.88;

const kPrimaryColor = Color(0xFFF2681B);
// const kPrimaryColor2 = Color.fromRGBO(215, 254, 106, 1);
const kSecondaryColor = Color.fromARGB(255, 224, 223, 222);
const kSecondaryColorLight = Color.fromRGBO(60, 61, 61, 1.0);
const kTertiaryColor = Color.fromARGB(255, 206, 205, 204);
const kTertiaryColorLight = Color.fromRGBO(30, 31, 30, 1);
const kTextColor = Colors.black;
const kSupportCard1 = Color.fromRGBO(131, 112, 232, 1.0);
const kSupportCard2 = Color.fromRGBO(43, 111, 201, 1.0);
const kSupportCard3 = Color.fromRGBO(47, 124, 133, 1.0);
const successColor = Color.fromRGBO(1, 165, 1, 1);
const errorColor = Color.fromRGBO(255, 0, 0, 1);
const kTransparent = Colors.transparent;
const kWhite = Colors.white;
const kGrey = Colors.grey;
const kGreen = Colors.green;
const kBlue = Colors.blue;
const kRed = Colors.red;
