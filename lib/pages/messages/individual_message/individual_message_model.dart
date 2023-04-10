import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class IndividualMessageModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Message widget.
  TextEditingController? messageController;
  String? Function(BuildContext, String?)? messageControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Send widget.
  ChatMessagesRecord? message;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    messageController?.dispose();
  }

  /// Additional helper methods are added here.

}
