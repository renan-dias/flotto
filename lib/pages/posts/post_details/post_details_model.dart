import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/post/post_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PostDetailsModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // Model for post component.
  late PostModel postModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    postModel = createModel(context, () => PostModel());
  }

  void dispose() {
    postModel.dispose();
  }

  /// Additional helper methods are added here.

}
