import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/story/story_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileOtherModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Create Document] action in NewChatButton widget.
  ChatsRecord? chat;
  // State field(s) for Timer_FollowButtonActions widget.
  int timerFollowButtonActionsMilliseconds = 200;
  String timerFollowButtonActionsValue =
      StopWatchTimer.getDisplayTime(200, milliSecond: false);
  StopWatchTimer timerFollowButtonActionsController =
      StopWatchTimer(mode: StopWatchMode.countDown);

  // Stores action output result for [Backend Call - Create Document] action in Timer_FollowButtonActions widget.
  NotificationsRecord? notification;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    timerFollowButtonActionsController.dispose();
  }

  /// Additional helper methods are added here.

}
