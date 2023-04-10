import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'todaytomonthnotification_followers_model.dart';
export 'todaytomonthnotification_followers_model.dart';

class TodaytomonthnotificationFollowersWidget extends StatefulWidget {
  const TodaytomonthnotificationFollowersWidget({
    Key? key,
    this.notification,
  }) : super(key: key);

  final NotificationsRecord? notification;

  @override
  _TodaytomonthnotificationFollowersWidgetState createState() =>
      _TodaytomonthnotificationFollowersWidgetState();
}

class _TodaytomonthnotificationFollowersWidgetState
    extends State<TodaytomonthnotificationFollowersWidget> {
  late TodaytomonthnotificationFollowersModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model =
        createModel(context, () => TodaytomonthnotificationFollowersModel());

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

    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(widget.notification!.userRef!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 12.0,
              height: 12.0,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        }
        final rowUsersRecord = snapshot.data!;
        return InkWell(
          onTap: () async {
            context.pushNamed(
              'ProfileOther',
              queryParams: {
                'username': serializeParam(
                  rowUsersRecord.username,
                  ParamType.String,
                ),
              }.withoutNulls,
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                child: Container(
                  width: 45.0,
                  height: 45.0,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    valueOrDefault<String>(
                      rowUsersRecord.photoUrl,
                      'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 6.0, 0.0),
                  child: custom_widgets.Notifications(
                    width: 400.0,
                    height: 50.0,
                    name: valueOrDefault<String>(
                      rowUsersRecord.username,
                      'user',
                    ),
                    notification: 'started following you.',
                    time: dateTimeFormat(
                      'relative',
                      widget.notification!.timeCreated!,
                      locale: FFLocalizations.of(context).languageCode,
                    ),
                  ),
                ),
              ),
              AuthUserStreamWidget(
                builder: (context) => StreamBuilder<List<FollowersRecord>>(
                  stream: queryFollowersRecord(
                    parent: rowUsersRecord.reference,
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 12.0,
                          height: 12.0,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                    List<FollowersRecord> containerFollowersRecordList =
                        snapshot.data!;
                    final containerFollowersRecord =
                        containerFollowersRecordList.isNotEmpty
                            ? containerFollowersRecordList.first
                            : null;
                    return InkWell(
                      onTap: () async {
                        if ((currentUserDocument?.following?.toList() ?? [])
                            .contains(rowUsersRecord.reference)) {
                          final usersUpdateData1 = {
                            'following': FieldValue.arrayRemove(
                                [rowUsersRecord.reference]),
                          };
                          await currentUserReference!.update(usersUpdateData1);

                          final followersUpdateData1 = {
                            'userRefs':
                                FieldValue.arrayRemove([currentUserReference]),
                          };
                          await containerFollowersRecord!.reference
                              .update(followersUpdateData1);
                          _model.timerController.onExecute
                              .add(StopWatchExecute.reset);
                        } else {
                          final usersUpdateData2 = {
                            'following': FieldValue.arrayUnion(
                                [rowUsersRecord.reference]),
                          };
                          await currentUserReference!.update(usersUpdateData2);

                          final followersUpdateData2 = {
                            'userRefs':
                                FieldValue.arrayUnion([currentUserReference]),
                          };
                          await containerFollowersRecord!.reference
                              .update(followersUpdateData2);
                          _model.timerController.onExecute
                              .add(StopWatchExecute.start);
                        }
                      },
                      child: Container(
                        width: 110.0,
                        height: 35.0,
                        decoration: BoxDecoration(
                          color:
                              (currentUserDocument?.following?.toList() ?? [])
                                      .contains(rowUsersRecord.reference)
                                  ? Color(0xFFEFEFEF)
                                  : FlutterFlowTheme.of(context).secondaryColor,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 6.0, 8.0, 6.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  (currentUserDocument?.following?.toList() ??
                                              [])
                                          .contains(rowUsersRecord.reference)
                                      ? 'Following'
                                      : 'Follow',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Inter',
                                        color: (currentUserDocument?.following
                                                        ?.toList() ??
                                                    [])
                                                .contains(
                                                    rowUsersRecord.reference)
                                            ? FlutterFlowTheme.of(context)
                                                .primaryText
                                            : Colors.white,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              FlutterFlowTimer(
                initialTime: _model.timerMilliseconds,
                getDisplayTime: (value) =>
                    StopWatchTimer.getDisplayTime(value, milliSecond: false),
                timer: _model.timerController,
                onChanged: (value, displayTime, shouldUpdate) {
                  _model.timerMilliseconds = value;
                  _model.timerValue = displayTime;
                  if (shouldUpdate) setState(() {});
                },
                onEnded: () async {
                  final notificationsCreateData = createNotificationsRecordData(
                    notificationType: 'Follow',
                    userRef: currentUserReference,
                    timeCreated: getCurrentTimestamp,
                  );
                  var notificationsRecordReference =
                      NotificationsRecord.createDoc(rowUsersRecord.reference);
                  await notificationsRecordReference
                      .set(notificationsCreateData);
                  _model.notification = NotificationsRecord.getDocumentFromData(
                      notificationsCreateData, notificationsRecordReference);

                  final usersUpdateData = {
                    'unreadNotifications':
                        FieldValue.arrayUnion([_model.notification!.reference]),
                  };
                  await rowUsersRecord.reference.update(usersUpdateData);

                  setState(() {});
                },
                textAlign: TextAlign.start,
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Inter',
                      color: FlutterFlowTheme.of(context).primaryColor,
                      fontSize: 0.0,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}
