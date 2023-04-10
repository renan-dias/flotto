import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/story/story_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'profile_other_model.dart';
export 'profile_other_model.dart';

class ProfileOtherWidget extends StatefulWidget {
  const ProfileOtherWidget({
    Key? key,
    this.username,
  }) : super(key: key);

  final String? username;

  @override
  _ProfileOtherWidgetState createState() => _ProfileOtherWidgetState();
}

class _ProfileOtherWidgetState extends State<ProfileOtherWidget> {
  late ProfileOtherModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileOtherModel());

    if (!isWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        setState(() {
          _isKeyboardVisible = visible;
        });
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    if (!isWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        iconTheme:
            IconThemeData(color: FlutterFlowTheme.of(context).primaryText),
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () async {
            context.pop();
          },
          child: Icon(
            FFIcons.karrowLeft,
            color: Colors.black,
            size: 24.0,
          ),
        ),
        title: Text(
          widget.username!,
          style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Inter',
                fontSize: 16.0,
              ),
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Builder(
                builder: (context) => Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
                  child: InkWell(
                    onTap: () async {
                      await Share.share(
                        'flotto://flotto.com${GoRouter.of(context).location}',
                        sharePositionOrigin: getWidgetBoundingBox(context),
                      );
                    },
                    child: Icon(
                      FFIcons.kmore,
                      color: Colors.black,
                      size: 28.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: StreamBuilder<List<UsersRecord>>(
                    stream: queryUsersRecord(
                      queryBuilder: (usersRecord) => usersRecord
                          .where('username', isEqualTo: widget.username),
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
                      List<UsersRecord> columnUsersRecordList = snapshot.data!;
                      // Return an empty Container when the item does not exist.
                      if (snapshot.data!.isEmpty) {
                        return Container();
                      }
                      final columnUsersRecord = columnUsersRecordList.isNotEmpty
                          ? columnUsersRecordList.first
                          : null;
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 15.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 20.0, 0.0),
                                    child: Stack(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      children: [
                                        StreamBuilder<List<StoriesRecord>>(
                                          stream: queryStoriesRecord(
                                            queryBuilder: (storiesRecord) =>
                                                storiesRecord
                                                    .where('user',
                                                        isEqualTo:
                                                            columnUsersRecord!
                                                                .reference)
                                                    .where('expire_time',
                                                        isGreaterThan:
                                                            getCurrentTimestamp),
                                            singleRecord: true,
                                          ),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 12.0,
                                                  height: 12.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              );
                                            }
                                            List<StoriesRecord>
                                                activeStoryIndicatorStoriesRecordList =
                                                snapshot.data!;
                                            // Return an empty Container when the item does not exist.
                                            if (snapshot.data!.isEmpty) {
                                              return Container();
                                            }
                                            final activeStoryIndicatorStoriesRecord =
                                                activeStoryIndicatorStoriesRecordList
                                                        .isNotEmpty
                                                    ? activeStoryIndicatorStoriesRecordList
                                                        .first
                                                    : null;
                                            return InkWell(
                                              onTap: () async {
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (context) {
                                                    return Padding(
                                                      padding:
                                                          MediaQuery.of(context)
                                                              .viewInsets,
                                                      child: StoryWidget(
                                                        story:
                                                            activeStoryIndicatorStoriesRecord,
                                                      ),
                                                    );
                                                  },
                                                ).then(
                                                    (value) => setState(() {}));
                                              },
                                              child: Container(
                                                width: 100.0,
                                                height: 100.0,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color(0xFF7C1E51),
                                                      Color(0xFFDE0046),
                                                      Color(0xFFF7A34B)
                                                    ],
                                                    stops: [0.0, 0.5, 1.0],
                                                    begin: AlignmentDirectional(
                                                        1.0, -1.0),
                                                    end: AlignmentDirectional(
                                                        -1.0, 1.0),
                                                  ),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Container(
                                            width: 93.0,
                                            height: 93.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: Image.network(
                                                  valueOrDefault<String>(
                                                    columnUsersRecord!.photoUrl,
                                                    'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg',
                                                  ),
                                                ).image,
                                              ),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryColor,
                                                width: 3.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 0.0, 0.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                StreamBuilder<
                                                    List<PostsRecord>>(
                                                  stream: queryPostsRecord(
                                                    queryBuilder: (postsRecord) =>
                                                        postsRecord.where(
                                                            'post_user',
                                                            isEqualTo:
                                                                columnUsersRecord!
                                                                    .reference),
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 12.0,
                                                          height: 12.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<PostsRecord>
                                                        numberPostsRecordList =
                                                        snapshot.data!;
                                                    return Text(
                                                      formatNumber(
                                                        numberPostsRecordList
                                                            .length,
                                                        formatType:
                                                            FormatType.compact,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            fontSize: 17.0,
                                                          ),
                                                    );
                                                  },
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 2.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Posts',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () async {
                                              context.pushNamed(
                                                'FollowersFollowingOther',
                                                queryParams: {
                                                  'userRef': serializeParam(
                                                    columnUsersRecord!
                                                        .reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                StreamBuilder<
                                                    List<FollowersRecord>>(
                                                  stream: queryFollowersRecord(
                                                    parent: columnUsersRecord!
                                                        .reference,
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 12.0,
                                                          height: 12.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<FollowersRecord>
                                                        numberFollowersRecordList =
                                                        snapshot.data!;
                                                    final numberFollowersRecord =
                                                        numberFollowersRecordList
                                                                .isNotEmpty
                                                            ? numberFollowersRecordList
                                                                .first
                                                            : null;
                                                    return Text(
                                                      valueOrDefault<String>(
                                                        formatNumber(
                                                          numberFollowersRecord!
                                                              .userRefs!
                                                              .toList()
                                                              .length,
                                                          formatType: FormatType
                                                              .compact,
                                                        ),
                                                        '0',
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            fontSize: 17.0,
                                                          ),
                                                    );
                                                  },
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 2.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Followers',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () async {
                                              context.pushNamed(
                                                'FollowersFollowingOther',
                                                queryParams: {
                                                  'userRef': serializeParam(
                                                    columnUsersRecord!
                                                        .reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  valueOrDefault<String>(
                                                    formatNumber(
                                                      columnUsersRecord!
                                                          .following!
                                                          .toList()
                                                          .length,
                                                      formatType:
                                                          FormatType.compact,
                                                    ),
                                                    '0',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        fontSize: 17.0,
                                                      ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 2.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Following',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (columnUsersRecord!.displayName != null &&
                                columnUsersRecord!.displayName != '')
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 6.0, 0.0, 0.0),
                                child: Text(
                                  columnUsersRecord!.displayName!,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Inter',
                                        fontSize: 15.0,
                                      ),
                                ),
                              ),
                            if (columnUsersRecord!.bio != null &&
                                columnUsersRecord!.bio != '')
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 4.0, 0.0, 0.0),
                                child: Text(
                                  columnUsersRecord!.bio!,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Inter',
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                            if (columnUsersRecord!.website != null &&
                                columnUsersRecord!.website != '')
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 4.0, 0.0, 0.0),
                                child: InkWell(
                                  onTap: () async {
                                    await launchURL(
                                        columnUsersRecord!.website!);
                                  },
                                  child: Text(
                                    columnUsersRecord!.website!,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Inter',
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 15.0, 15.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 6.0, 0.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => StreamBuilder<
                                            List<FollowersRecord>>(
                                          stream: queryFollowersRecord(
                                            parent:
                                                columnUsersRecord!.reference,
                                            singleRecord: true,
                                          ),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 12.0,
                                                  height: 12.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              );
                                            }
                                            List<FollowersRecord>
                                                followUnfollowButtonFollowersRecordList =
                                                snapshot.data!;
                                            final followUnfollowButtonFollowersRecord =
                                                followUnfollowButtonFollowersRecordList
                                                        .isNotEmpty
                                                    ? followUnfollowButtonFollowersRecordList
                                                        .first
                                                    : null;
                                            return InkWell(
                                              onTap: () async {
                                                if ((currentUserDocument
                                                            ?.following
                                                            ?.toList() ??
                                                        [])
                                                    .contains(columnUsersRecord!
                                                        .reference)) {
                                                  final usersUpdateData1 = {
                                                    'following':
                                                        FieldValue.arrayRemove([
                                                      columnUsersRecord!
                                                          .reference
                                                    ]),
                                                  };
                                                  await currentUserReference!
                                                      .update(usersUpdateData1);

                                                  final followersUpdateData1 = {
                                                    'userRefs':
                                                        FieldValue.arrayRemove([
                                                      currentUserReference
                                                    ]),
                                                  };
                                                  await followUnfollowButtonFollowersRecord!
                                                      .reference
                                                      .update(
                                                          followersUpdateData1);
                                                  _model
                                                      .timerFollowButtonActionsController
                                                      .onExecute
                                                      .add(StopWatchExecute
                                                          .reset);
                                                } else {
                                                  final usersUpdateData2 = {
                                                    'following':
                                                        FieldValue.arrayUnion([
                                                      columnUsersRecord!
                                                          .reference
                                                    ]),
                                                  };
                                                  await currentUserReference!
                                                      .update(usersUpdateData2);

                                                  final followersUpdateData2 = {
                                                    'userRefs':
                                                        FieldValue.arrayUnion([
                                                      currentUserReference
                                                    ]),
                                                  };
                                                  await followUnfollowButtonFollowersRecord!
                                                      .reference
                                                      .update(
                                                          followersUpdateData2);
                                                  _model
                                                      .timerFollowButtonActionsController
                                                      .onExecute
                                                      .add(StopWatchExecute
                                                          .start);
                                                }
                                              },
                                              child: Container(
                                                height: 35.0,
                                                decoration: BoxDecoration(
                                                  color: (currentUserDocument
                                                                  ?.following
                                                                  ?.toList() ??
                                                              [])
                                                          .contains(
                                                              columnUsersRecord!
                                                                  .reference)
                                                      ? Color(0xFFEFEFEF)
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 6.0,
                                                                8.0, 6.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          () {
                                                            if (columnUsersRecord!
                                                                    .following!
                                                                    .toList()
                                                                    .contains(
                                                                        currentUserReference) &&
                                                                !(currentUserDocument
                                                                            ?.following
                                                                            ?.toList() ??
                                                                        [])
                                                                    .contains(
                                                                        columnUsersRecord!
                                                                            .reference)) {
                                                              return 'Follow back';
                                                            } else if (!columnUsersRecord!
                                                                    .following!
                                                                    .toList()
                                                                    .contains(
                                                                        currentUserReference) &&
                                                                !(currentUserDocument
                                                                            ?.following
                                                                            ?.toList() ??
                                                                        [])
                                                                    .contains(
                                                                        columnUsersRecord!
                                                                            .reference)) {
                                                              return 'Follow';
                                                            } else {
                                                              return 'Unfollow';
                                                            }
                                                          }(),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Inter',
                                                                color: (currentUserDocument?.following?.toList() ??
                                                                            [])
                                                                        .contains(columnUsersRecord!
                                                                            .reference)
                                                                    ? FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText
                                                                    : Colors
                                                                        .white,
                                                                fontSize: 13.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
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
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          6.0, 0.0, 0.0, 0.0),
                                      child: Stack(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              FFAppState().update(() {
                                                FFAppState().tempUserList = [];
                                                FFAppState().addToTempUserList(
                                                    currentUserReference!);
                                              });
                                              FFAppState().update(() {
                                                FFAppState().addToTempUserList(
                                                    columnUsersRecord!
                                                        .reference);
                                              });

                                              final chatsCreateData = {
                                                ...createChatsRecordData(
                                                  userA: currentUserReference,
                                                  userB: columnUsersRecord!
                                                      .reference,
                                                  lastMessage:
                                                      'Hey! Let\'s chat!',
                                                  lastMessageTime:
                                                      getCurrentTimestamp,
                                                  lastMessageSentBy:
                                                      currentUserReference,
                                                ),
                                                'last_message_seen_by': [
                                                  currentUserReference
                                                ],
                                                'users':
                                                    FFAppState().tempUserList,
                                              };
                                              var chatsRecordReference =
                                                  ChatsRecord.collection.doc();
                                              await chatsRecordReference
                                                  .set(chatsCreateData);
                                              _model.chat = ChatsRecord
                                                  .getDocumentFromData(
                                                      chatsCreateData,
                                                      chatsRecordReference);

                                              context.pushNamed(
                                                'IndividualMessage',
                                                queryParams: {
                                                  'chat': serializeParam(
                                                    _model.chat!.reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                }.withoutNulls,
                                              );

                                              setState(() {});
                                            },
                                            child: Container(
                                              height: 35.0,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFEFEFEF),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          8.0, 6.0, 8.0, 6.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Message',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyText1
                                                            .override(
                                                              fontFamily:
                                                                  'Inter',
                                                              fontSize: 13.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          StreamBuilder<List<ChatsRecord>>(
                                            stream: queryChatsRecord(
                                              queryBuilder: (chatsRecord) =>
                                                  chatsRecord
                                                      .where(
                                                          'user_a',
                                                          isEqualTo:
                                                              columnUsersRecord!
                                                                  .reference)
                                                      .where('user_b',
                                                          isEqualTo:
                                                              currentUserReference),
                                              singleRecord: true,
                                            ),
                                            builder: (context, snapshot) {
                                              // Customize what your widget looks like when it's loading.
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child: SizedBox(
                                                    width: 12.0,
                                                    height: 12.0,
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                );
                                              }
                                              List<ChatsRecord>
                                                  messageButton1ChatsRecordList =
                                                  snapshot.data!;
                                              // Return an empty Container when the item does not exist.
                                              if (snapshot.data!.isEmpty) {
                                                return Container();
                                              }
                                              final messageButton1ChatsRecord =
                                                  messageButton1ChatsRecordList
                                                          .isNotEmpty
                                                      ? messageButton1ChatsRecordList
                                                          .first
                                                      : null;
                                              return InkWell(
                                                onTap: () async {
                                                  context.pushNamed(
                                                    'IndividualMessage',
                                                    queryParams: {
                                                      'chat': serializeParam(
                                                        messageButton1ChatsRecord!
                                                            .reference,
                                                        ParamType
                                                            .DocumentReference,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                },
                                                child: Container(
                                                  height: 35.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFEFEFEF),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  8.0,
                                                                  6.0,
                                                                  8.0,
                                                                  6.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'Message',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontSize:
                                                                      13.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
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
                                          StreamBuilder<List<ChatsRecord>>(
                                            stream: queryChatsRecord(
                                              queryBuilder: (chatsRecord) =>
                                                  chatsRecord
                                                      .where(
                                                          'user_a',
                                                          isEqualTo:
                                                              currentUserReference)
                                                      .where('user_b',
                                                          isEqualTo:
                                                              columnUsersRecord!
                                                                  .reference),
                                              singleRecord: true,
                                            ),
                                            builder: (context, snapshot) {
                                              // Customize what your widget looks like when it's loading.
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child: SizedBox(
                                                    width: 12.0,
                                                    height: 12.0,
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                );
                                              }
                                              List<ChatsRecord>
                                                  messageButton2ChatsRecordList =
                                                  snapshot.data!;
                                              // Return an empty Container when the item does not exist.
                                              if (snapshot.data!.isEmpty) {
                                                return Container();
                                              }
                                              final messageButton2ChatsRecord =
                                                  messageButton2ChatsRecordList
                                                          .isNotEmpty
                                                      ? messageButton2ChatsRecordList
                                                          .first
                                                      : null;
                                              return InkWell(
                                                onTap: () async {
                                                  context.pushNamed(
                                                    'IndividualMessage',
                                                    queryParams: {
                                                      'chat': serializeParam(
                                                        messageButton2ChatsRecord!
                                                            .reference,
                                                        ParamType
                                                            .DocumentReference,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                },
                                                child: Container(
                                                  height: 35.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFEFEFEF),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  8.0,
                                                                  6.0,
                                                                  8.0,
                                                                  6.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'Message',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontSize:
                                                                      13.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
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
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (columnUsersRecord!.enableEmail ?? true)
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 0.0, 0.0),
                                        child: InkWell(
                                          onTap: () async {
                                            await launchUrl(Uri(
                                              scheme: 'mailto',
                                              path: columnUsersRecord!.email!,
                                            ));
                                          },
                                          child: Container(
                                            height: 35.0,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFEFEFEF),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        8.0, 6.0, 8.0, 6.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Email',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            fontSize: 13.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  FlutterFlowTimer(
                                    initialTime: _model
                                        .timerFollowButtonActionsMilliseconds,
                                    getDisplayTime: (value) =>
                                        StopWatchTimer.getDisplayTime(value,
                                            milliSecond: false),
                                    timer: _model
                                        .timerFollowButtonActionsController,
                                    onChanged:
                                        (value, displayTime, shouldUpdate) {
                                      _model.timerFollowButtonActionsMilliseconds =
                                          value;
                                      _model.timerFollowButtonActionsValue =
                                          displayTime;
                                      if (shouldUpdate) setState(() {});
                                    },
                                    onEnded: () async {
                                      final notificationsCreateData =
                                          createNotificationsRecordData(
                                        notificationType: 'Follow',
                                        userRef: currentUserReference,
                                        timeCreated: getCurrentTimestamp,
                                      );
                                      var notificationsRecordReference =
                                          NotificationsRecord.createDoc(
                                              columnUsersRecord!.reference);
                                      await notificationsRecordReference
                                          .set(notificationsCreateData);
                                      _model.notification = NotificationsRecord
                                          .getDocumentFromData(
                                              notificationsCreateData,
                                              notificationsRecordReference);

                                      final usersUpdateData = {
                                        'unreadNotifications':
                                            FieldValue.arrayUnion([
                                          _model.notification!.reference
                                        ]),
                                      };
                                      await columnUsersRecord!.reference
                                          .update(usersUpdateData);

                                      setState(() {});
                                    },
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Inter',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                          fontSize: 0.0,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 550.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 12.0, 0.0, 0.0),
                                child: DefaultTabController(
                                  length: 2,
                                  initialIndex: 0,
                                  child: Column(
                                    children: [
                                      TabBar(
                                        labelColor: Colors.black,
                                        unselectedLabelColor: Color(0x80000000),
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Inter',
                                              fontSize: 0.0,
                                              lineHeight: 0.0,
                                            ),
                                        indicatorColor: Colors.black,
                                        indicatorWeight: 2.0,
                                        tabs: [
                                          Tab(
                                            icon: Icon(
                                              FFIcons.kgrid,
                                              size: 30.0,
                                            ),
                                          ),
                                          Tab(
                                            icon: Icon(
                                              FFIcons.kmentions,
                                              size: 28.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: TabBarView(
                                          children: [
                                            KeepAliveWidgetWrapper(
                                              builder: (context) =>
                                                  StreamBuilder<
                                                      List<PostsRecord>>(
                                                stream: queryPostsRecord(
                                                  queryBuilder: (postsRecord) =>
                                                      postsRecord
                                                          .where(
                                                              'post_user',
                                                              isEqualTo:
                                                                  columnUsersRecord!
                                                                      .reference)
                                                          .where('deleted',
                                                              isEqualTo: false)
                                                          .orderBy(
                                                              'time_posted',
                                                              descending: true),
                                                ),
                                                builder: (context, snapshot) {
                                                  // Customize what your widget looks like when it's loading.
                                                  if (!snapshot.hasData) {
                                                    return Center(
                                                      child: SizedBox(
                                                        width: 12.0,
                                                        height: 12.0,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  List<PostsRecord>
                                                      profilePhotosPostsRecordList =
                                                      snapshot.data!;
                                                  return GridView.builder(
                                                    padding: EdgeInsets.zero,
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      crossAxisSpacing: 1.0,
                                                      mainAxisSpacing: 1.0,
                                                      childAspectRatio: 1.0,
                                                    ),
                                                    primary: false,
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount:
                                                        profilePhotosPostsRecordList
                                                            .length,
                                                    itemBuilder: (context,
                                                        profilePhotosIndex) {
                                                      final profilePhotosPostsRecord =
                                                          profilePhotosPostsRecordList[
                                                              profilePhotosIndex];
                                                      return InkWell(
                                                        onTap: () async {
                                                          context.pushNamed(
                                                            'PostDetails',
                                                            queryParams: {
                                                              'post':
                                                                  serializeParam(
                                                                profilePhotosPostsRecord
                                                                    .reference,
                                                                ParamType
                                                                    .DocumentReference,
                                                              ),
                                                            }.withoutNulls,
                                                          );
                                                        },
                                                        child: Hero(
                                                          tag:
                                                              profilePhotosPostsRecord
                                                                  .postPhoto!,
                                                          transitionOnUserGestures:
                                                              true,
                                                          child: Image.network(
                                                            profilePhotosPostsRecord
                                                                .postPhoto!,
                                                            width: 100.0,
                                                            height: 100.0,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                            KeepAliveWidgetWrapper(
                                              builder: (context) =>
                                                  StreamBuilder<
                                                      List<PostsRecord>>(
                                                stream: queryPostsRecord(
                                                  queryBuilder: (postsRecord) =>
                                                      postsRecord
                                                          .where(
                                                              'tagged_users',
                                                              arrayContains:
                                                                  columnUsersRecord!
                                                                      .reference)
                                                          .where('deleted',
                                                              isEqualTo: false)
                                                          .orderBy(
                                                              'time_posted',
                                                              descending: true),
                                                ),
                                                builder: (context, snapshot) {
                                                  // Customize what your widget looks like when it's loading.
                                                  if (!snapshot.hasData) {
                                                    return Center(
                                                      child: SizedBox(
                                                        width: 12.0,
                                                        height: 12.0,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  List<PostsRecord>
                                                      taggedPhotosPostsRecordList =
                                                      snapshot.data!;
                                                  return GridView.builder(
                                                    padding: EdgeInsets.zero,
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      crossAxisSpacing: 1.0,
                                                      mainAxisSpacing: 1.0,
                                                      childAspectRatio: 1.0,
                                                    ),
                                                    primary: false,
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount:
                                                        taggedPhotosPostsRecordList
                                                            .length,
                                                    itemBuilder: (context,
                                                        taggedPhotosIndex) {
                                                      final taggedPhotosPostsRecord =
                                                          taggedPhotosPostsRecordList[
                                                              taggedPhotosIndex];
                                                      return InkWell(
                                                        onTap: () async {
                                                          context.pushNamed(
                                                            'PostDetails',
                                                            queryParams: {
                                                              'post':
                                                                  serializeParam(
                                                                taggedPhotosPostsRecord
                                                                    .reference,
                                                                ParamType
                                                                    .DocumentReference,
                                                              ),
                                                            }.withoutNulls,
                                                          );
                                                        },
                                                        child: Hero(
                                                          tag:
                                                              taggedPhotosPostsRecord
                                                                  .postPhoto!,
                                                          transitionOnUserGestures:
                                                              true,
                                                          child: Image.network(
                                                            taggedPhotosPostsRecord
                                                                .postPhoto!,
                                                            width: 100.0,
                                                            height: 100.0,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (!(isWeb
                  ? MediaQuery.of(context).viewInsets.bottom > 0
                  : _isKeyboardVisible))
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 0.5,
                      decoration: BoxDecoration(
                        color: Color(0xFFDADADA),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 1.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 12.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      HapticFeedback.lightImpact();

                                      context.pushNamed(
                                        'Feed',
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.fade,
                                            duration: Duration(milliseconds: 0),
                                          ),
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional(0.0, 1.0),
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Icon(
                                                  FFIcons.khome,
                                                  color: Colors.black,
                                                  size: 28.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                          if ((currentUserDocument
                                                          ?.unreadNotifications
                                                          ?.toList() ??
                                                      [])
                                                  .length >
                                              0)
                                            AuthUserStreamWidget(
                                              builder: (context) => Container(
                                                width: 5.0,
                                                height: 5.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFF83639),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      HapticFeedback.lightImpact();

                                      context.pushNamed(
                                        'Search',
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.fade,
                                            duration: Duration(milliseconds: 0),
                                          ),
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 55.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 1.0),
                                            child: Icon(
                                              FFIcons.ksearch,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 26.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      HapticFeedback.lightImpact();

                                      context.pushNamed(
                                        'Profile',
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.fade,
                                            duration: Duration(milliseconds: 0),
                                          ),
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 55.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              Container(
                                                width: 36.0,
                                                height: 36.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: AuthUserStreamWidget(
                                                  builder: (context) =>
                                                      Container(
                                                    width: 33.0,
                                                    height: 33.0,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: Image.network(
                                                          valueOrDefault<
                                                              String>(
                                                            currentUserPhoto,
                                                            'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg',
                                                          ),
                                                        ).image,
                                                      ),
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryColor,
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
