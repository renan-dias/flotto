import '/backend/backend.dart';
import '/components/tagged_users_component/tagged_users_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'tagged_users_model.dart';
export 'tagged_users_model.dart';

class TaggedUsersWidget extends StatefulWidget {
  const TaggedUsersWidget({
    Key? key,
    this.post,
  }) : super(key: key);

  final PostsRecord? post;

  @override
  _TaggedUsersWidgetState createState() => _TaggedUsersWidgetState();
}

class _TaggedUsersWidgetState extends State<TaggedUsersWidget> {
  late TaggedUsersModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TaggedUsersModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0),
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 40.0,
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFDADADA),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 12.0),
                  child: Text(
                    'In this photo',
                    style: FlutterFlowTheme.of(context).subtitle1,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 0.5,
                  decoration: BoxDecoration(
                    color: Color(0xFFDADADA),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(15.0, 12.0, 15.0, 24.0),
                  child: Builder(
                    builder: (context) {
                      final taggedUsers = widget.post!.taggedUsers!.toList();
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(taggedUsers.length,
                            (taggedUsersIndex) {
                          final taggedUsersItem = taggedUsers[taggedUsersIndex];
                          return TaggedUsersComponentWidget(
                            key: Key(
                                'Keyjet_${taggedUsersIndex}_of_${taggedUsers.length}'),
                            user: taggedUsersItem,
                          );
                        }),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
