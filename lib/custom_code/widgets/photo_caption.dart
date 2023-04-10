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

class PhotoCaption extends StatefulWidget {
  const PhotoCaption({
    Key? key,
    this.width,
    this.height,
    required this.name,
    required this.caption,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String name;
  final String caption;

  @override
  _PhotoCaptionState createState() => _PhotoCaptionState();
}

class _PhotoCaptionState extends State<PhotoCaption> {
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
                    text: widget.caption,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Inter',
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
