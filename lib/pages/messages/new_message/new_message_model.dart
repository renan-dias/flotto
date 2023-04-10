import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';

class NewMessageModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for SearchInnput widget.
  TextEditingController? searchInnputController;
  String? Function(BuildContext, String?)? searchInnputControllerValidator;
  List<UsersRecord> simpleSearchResults = [];
  // State field(s) for Timer widget.
  int timerMilliseconds = 100;
  String timerValue = StopWatchTimer.getDisplayTime(
    100,
    hours: false,
    minute: false,
    milliSecond: false,
  );
  StopWatchTimer timerController =
      StopWatchTimer(mode: StopWatchMode.countDown);

  // Stores action output result for [Backend Call - Create Document] action in ProfileDetails widget.
  ChatsRecord? chat;
  // Stores action output result for [Backend Call - Create Document] action in ProfileDetails widget.
  ChatsRecord? chat1;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    searchInnputController?.dispose();
    timerController.dispose();
  }

  /// Additional helper methods are added here.

}
