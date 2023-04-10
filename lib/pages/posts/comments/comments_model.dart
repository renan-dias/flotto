import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/post_options/post_options_widget.dart';
import '/components/send_post/send_post_widget.dart';
import '/components/story/story_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CommentsModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Create Document] action in Icon widget.
  NotificationsRecord? notification;
  // State field(s) for Comment widget.
  TextEditingController? commentController;
  String? Function(BuildContext, String?)? commentControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Text widget.
  CommentsRecord? comment;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    commentController?.dispose();
  }

  /// Additional helper methods are added here.

}
