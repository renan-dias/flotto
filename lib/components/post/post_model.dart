import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/personal_post_options/personal_post_options_widget.dart';
import '/components/post_options/post_options_widget.dart';
import '/components/send_post/send_post_widget.dart';
import '/components/tagged_users/tagged_users_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PostModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Create Document] action in Image widget.
  NotificationsRecord? notification;
  // Stores action output result for [Backend Call - Create Document] action in Icon widget.
  NotificationsRecord? notification1;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Additional helper methods are added here.

}
