
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;


const barterPrimary = Color(0xff10141e);
const barterPrimary3 = Color(0xff1e253a);
const barterPrimary2 = Color(0xff08bf98);
const bodyText1 = Color(0xffffffff);
const bodyText2 = Color(0xffffffff);

//const hostName = "http://192.168.43.121:8000";
//const socketHostName = "ws://192.168.43.121:8000";


const googleAPiKey = "AIzaSyC3GI3QkJxwxDesAvuQXAdFhQtExmAlcg4";




const hostName = "http://92.112.194.239:82";
const socketHostName = "ws://92.112.194.239:82";



Future<String?> getApiPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("API_Key");
}



Future<String?> getUserIDPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("USER_ID");
}

String capitalizeString(String str) {
  if (str.isEmpty) {
    return str;
  }
  return str[0].toUpperCase() + str.substring(1);
}


bool validatePhoneNumber(String phoneNumber) {
  // Regular expression for international phone number validation
  final RegExp regex = RegExp(r'^\+\d{12}$');

  return regex.hasMatch(phoneNumber);
}

String convertToTimeAgo(String timestamp) {
  DateTime parsedTime = DateTime.parse(timestamp).toLocal();
  DateTime now = DateTime.now();
  Duration difference = now.difference(parsedTime);
  return timeago.format(now.subtract(difference));
}



Future<File?> compressImage(File? imageFile) async {
  if (imageFile == null) return null;

  // Get the image file size
  int fileSizeInBytes = imageFile.lengthSync();
  double fileSizeInKB = fileSizeInBytes / 1024;
  double fileSizeInMB = fileSizeInKB / 1024;

  // Check if image size is already below 2MB
  if (fileSizeInMB < 2) {
    return imageFile;
  }

  // Compress the image
  List<int> compressedBytes = (await FlutterImageCompress.compressWithFile(
    imageFile.absolute.path,
    quality: 70, // Adjust the quality value as needed
  )) as List<int>;

  // Create a new compressed image file
  File compressedFile = File(imageFile.path);
  await compressedFile.writeAsBytes(compressedBytes);

  return compressedFile;
}

