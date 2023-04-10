import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignUpUsernameConfirmationModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Email_HIDDEN widget.
  TextEditingController? emailHIDDENController;
  String? Function(BuildContext, String?)? emailHIDDENControllerValidator;
  // State field(s) for Password_HIDDEN widget.
  TextEditingController? passwordHIDDENController;
  late bool passwordHIDDENVisibility;
  String? Function(BuildContext, String?)? passwordHIDDENControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    passwordHIDDENVisibility = false;
  }

  void dispose() {
    emailHIDDENController?.dispose();
    passwordHIDDENController?.dispose();
  }

  /// Additional helper methods are added here.

}
