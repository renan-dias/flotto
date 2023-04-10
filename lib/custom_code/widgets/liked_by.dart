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

class LikedBy extends StatefulWidget {
  const LikedBy({
    Key? key,
    this.width,
    this.height,
    required this.name,
    required this.number,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String name;
  final String number;

  @override
  _LikedByState createState() => _LikedByState();
}

class _LikedByState extends State<LikedBy> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: const BoxDecoration(),
      child: Align(
        alignment: const AlignmentDirectional(-1, -1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: 'Liked by ',
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.normal,
                    ),
                children: <TextSpan>[
                  TextSpan(
                    text: widget.name,
                    style: FlutterFlowTheme.of(context).bodyText1,
                  ),
                  TextSpan(
                    text: ' and ',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  TextSpan(
                    text: widget.number,
                    style: FlutterFlowTheme.of(context).bodyText1,
                  ),
                  TextSpan(
                    text: ' others',
                    style: FlutterFlowTheme.of(context).bodyText1,
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
