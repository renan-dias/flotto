import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/auth_util.dart';

DocumentReference returnUserFromLikes(List<DocumentReference> userLikes) {
  // Return an item from the list
  DocumentReference likedUser = userLikes[
      0]; // Put your method here and link with tag on run method in main.dart
  return likedUser;
}

DateTime tomorrowTime(DateTime currentTime) {
  // Return the timestamp in the future 24 hours.
  var tomorrow = DateTime.now().add(Duration(days: 1));
  return DateTime(tomorrow.year, tomorrow.month, tomorrow.day, currentTime.hour,
      currentTime.minute, 0);
}

int totalLikes(int numberoflikes) {
  // return the numberoflikes minus 1
  return numberoflikes - 1;
}

String listToString(List<String>? list) {
  // take list and convert to string with a ", " between each item
  String res = '';
  if (list != null) {
    for (String item in list) {
      res += ('${item.toString()}, ');
    }
  }
  return res;
}

List<DocumentReference>? reverseList(
    List<DocumentReference>? notificationsList) {
  // reverse the list
  if (notificationsList != null && notificationsList.length > 1) {
    if (notificationsList[0] == notificationsList.last)
      return notificationsList;

    // reverse and return
    return notificationsList.reversed.toList();
  } else
    return notificationsList;
}

DateTime returnThisMorning(DateTime currentTime) {
  // Return the start of today
  DateTime now = currentTime;
  DateTime _thisMorning = DateTime(now.year, now.month, now.day);
  return _thisMorning;
}

DateTime returnThisWeek(DateTime currentTime) {
  // Return the date 1 week ago
  return currentTime.subtract(Duration(days: 7));
}

DateTime returnThisMonth(DateTime currentTime) {
  // Return the date 1 week ago
  return DateTime(currentTime.year, currentTime.month - 1, currentTime.day);
}

String returnAllCaps(String username) {
  // Return string in all caps
  return username.toUpperCase();
}

DateTimeRange returnNext24Hours(DateTime currentTime) {
  // Create a range of time from now until 24 hours from now.
  Duration fromNowAcceptable = Duration(hours: 24);
  DateTime tomorrow = DateTime(
    currentTime.year,
    currentTime.month,
    currentTime.day,
    currentTime.hour,
    currentTime.minute,
  ).add(fromNowAcceptable);
  DateTimeRange dateTimeRangeFromNow =
      DateTimeRange(start: currentTime, end: tomorrow);
  return dateTimeRangeFromNow;
}
