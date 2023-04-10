// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class Notifications extends StatefulWidget {
  const Notifications({
    Key? key,
    this.width,
    this.height,
    required this.name,
    required this.notification,
    required this.time,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String name;
  final String notification;
  final String time;

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: const BoxDecoration(),
      child: Align(
        alignment: const AlignmentDirectional(-1, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: widget.name,
                style: FlutterFlowTheme.of(context).bodyText1,
                children: <TextSpan>[
                  TextSpan(
                    text: ' ',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  TextSpan(
                    text: widget.notification,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  TextSpan(
                    text: ' ',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  TextSpan(
                    text: widget.time,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Inter',
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
