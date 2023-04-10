import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'individual_message_model.dart';
export 'individual_message_model.dart';

class IndividualMessageWidget extends StatefulWidget {
  const IndividualMessageWidget({
    Key? key,
    this.chat,
  }) : super(key: key);

  final DocumentReference? chat;

  @override
  _IndividualMessageWidgetState createState() =>
      _IndividualMessageWidgetState();
}

class _IndividualMessageWidgetState extends State<IndividualMessageWidget> {
  late IndividualMessageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IndividualMessageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      final chatsUpdateData = {
        'last_message_seen_by': FieldValue.arrayUnion([currentUserReference]),
      };
      await widget.chat!.update(chatsUpdateData);
    });

    _model.messageController ??= TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
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
        automaticallyImplyLeading: false,
        title: StreamBuilder<ChatsRecord>(
          stream: ChatsRecord.getDocument(widget.chat!),
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
            final rowChatsRecord = snapshot.data!;
            return Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  onTap: () async {
                    context.pushNamed(
                      'Messages',
                      extra: <String, dynamic>{
                        kTransitionInfoKey: TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.leftToRight,
                        ),
                      },
                    );
                  },
                  child: Icon(
                    FFIcons.karrowLeft,
                    color: Colors.black,
                    size: 24.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 0.0, 0.0),
                  child: StreamBuilder<UsersRecord>(
                    stream: UsersRecord.getDocument(
                        rowChatsRecord.userA == currentUserReference
                            ? rowChatsRecord.userB!
                            : rowChatsRecord.userA!),
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
                      final usernameUsersRecord = snapshot.data!;
                      return Text(
                        usernameUsersRecord.username!,
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Inter',
                              fontSize: 24.0,
                            ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  onTap: () async {
                    await widget.chat!.delete();
                  },
                  child: Icon(
                    Icons.delete_outline_outlined,
                    color: Colors.black,
                    size: 26.0,
                  ),
                ),
              ],
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 0.5,
                decoration: BoxDecoration(
                  color: Color(0xFFDADADA),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, 1.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 100.0),
                          child: StreamBuilder<List<ChatMessagesRecord>>(
                            stream: queryChatMessagesRecord(
                              queryBuilder: (chatMessagesRecord) =>
                                  chatMessagesRecord
                                      .where('chat', isEqualTo: widget.chat)
                                      .orderBy('timestamp', descending: true),
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
                              List<ChatMessagesRecord>
                                  messageChatMessagesRecordList =
                                  snapshot.data!;
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                reverse: true,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: messageChatMessagesRecordList.length,
                                itemBuilder: (context, messageIndex) {
                                  final messageChatMessagesRecord =
                                      messageChatMessagesRecordList[
                                          messageIndex];
                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if (messageChatMessagesRecord.user ==
                                          currentUserReference)
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  15.0, 0.0, 15.0, 4.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.75,
                                                decoration: BoxDecoration(),
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          1.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      if ((messageChatMessagesRecord
                                                                  .postRef ==
                                                              null) &&
                                                          (messageChatMessagesRecord
                                                                  .commentRef ==
                                                              null))
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xFF444AFB),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              32.0),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              8.0),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              32.0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              8.0),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            10.0,
                                                                            16.0,
                                                                            10.0),
                                                                    child: Text(
                                                                      messageChatMessagesRecord
                                                                          .text!,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText1
                                                                          .override(
                                                                            fontFamily:
                                                                                'Inter',
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                15.0,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            lineHeight:
                                                                                1.5,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      if ((messageChatMessagesRecord
                                                                  .postRef !=
                                                              null) &&
                                                          (messageChatMessagesRecord
                                                                  .commentRef !=
                                                              null))
                                                        InkWell(
                                                          onTap: () async {
                                                            context.pushNamed(
                                                              'PostDetails',
                                                              queryParams: {
                                                                'post':
                                                                    serializeParam(
                                                                  messageChatMessagesRecord
                                                                      .postRef,
                                                                  ParamType
                                                                      .DocumentReference,
                                                                ),
                                                              }.withoutNulls,
                                                            );
                                                          },
                                                          child: Stack(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    1.0, 1.0),
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            20.0),
                                                                child: StreamBuilder<
                                                                    PostsRecord>(
                                                                  stream: PostsRecord
                                                                      .getDocument(
                                                                          messageChatMessagesRecord
                                                                              .postRef!),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    // Customize what your widget looks like when it's loading.
                                                                    if (!snapshot
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              12.0,
                                                                          height:
                                                                              12.0,
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                    final postPhotoPostsRecord =
                                                                        snapshot
                                                                            .data!;
                                                                    return ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16.0),
                                                                      child: Image
                                                                          .network(
                                                                        postPhotoPostsRecord
                                                                            .postPhoto!,
                                                                        width:
                                                                            200.0,
                                                                        height:
                                                                            200.0,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            24.0,
                                                                            0.0),
                                                                child: StreamBuilder<
                                                                    CommentsRecord>(
                                                                  stream: CommentsRecord
                                                                      .getDocument(
                                                                          messageChatMessagesRecord
                                                                              .commentRef!),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    // Customize what your widget looks like when it's loading.
                                                                    if (!snapshot
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              12.0,
                                                                          height:
                                                                              12.0,
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                    final postCommentCommentsRecord =
                                                                        snapshot
                                                                            .data!;
                                                                    return Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(0xFFF5F5F5),
                                                                            borderRadius:
                                                                                BorderRadius.circular(16.0),
                                                                          ),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                                                                                  child: FutureBuilder<UsersRecord>(
                                                                                    future: UsersRecord.getDocumentOnce(postCommentCommentsRecord.postUser!),
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
                                                                                      return Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Align(
                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                                                                                              child: InkWell(
                                                                                                onTap: () async {
                                                                                                  if (rowUsersRecord.reference == currentUserReference) {
                                                                                                    context.pushNamed('Profile');
                                                                                                  } else {
                                                                                                    context.pushNamed(
                                                                                                      'ProfileOther',
                                                                                                      queryParams: {
                                                                                                        'username': serializeParam(
                                                                                                          rowUsersRecord.username,
                                                                                                          ParamType.String,
                                                                                                        ),
                                                                                                      }.withoutNulls,
                                                                                                    );
                                                                                                  }
                                                                                                },
                                                                                                child: Container(
                                                                                                  width: 37.0,
                                                                                                  height: 37.0,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                    image: DecorationImage(
                                                                                                      fit: BoxFit.cover,
                                                                                                      image: Image.network(
                                                                                                        valueOrDefault<String>(
                                                                                                          rowUsersRecord.photoUrl,
                                                                                                          'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg',
                                                                                                        ),
                                                                                                      ).image,
                                                                                                    ),
                                                                                                    shape: BoxShape.circle,
                                                                                                    border: Border.all(
                                                                                                      color: FlutterFlowTheme.of(context).primaryColor,
                                                                                                      width: 2.0,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: Column(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              children: [
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 9.0, 0.0, 0.0),
                                                                                                  child: InkWell(
                                                                                                    onTap: () async {
                                                                                                      if (rowUsersRecord.reference == currentUserReference) {
                                                                                                        context.pushNamed('Profile');
                                                                                                      } else {
                                                                                                        context.pushNamed(
                                                                                                          'ProfileOther',
                                                                                                          queryParams: {
                                                                                                            'username': serializeParam(
                                                                                                              rowUsersRecord.username,
                                                                                                              ParamType.String,
                                                                                                            ),
                                                                                                          }.withoutNulls,
                                                                                                        );
                                                                                                      }
                                                                                                    },
                                                                                                    child: custom_widgets.PhotoCaption(
                                                                                                      width: double.infinity,
                                                                                                      height: 17.0,
                                                                                                      name: valueOrDefault<String>(
                                                                                                        rowUsersRecord.username,
                                                                                                        'user',
                                                                                                      ),
                                                                                                      caption: postCommentCommentsRecord.comment!,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ],
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
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      if ((messageChatMessagesRecord
                                                                  .postRef !=
                                                              null) &&
                                                          (messageChatMessagesRecord
                                                                  .commentRef ==
                                                              null))
                                                        StreamBuilder<
                                                            PostsRecord>(
                                                          stream: PostsRecord
                                                              .getDocument(
                                                                  messageChatMessagesRecord
                                                                      .postRef!),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Center(
                                                                child: SizedBox(
                                                                  width: 12.0,
                                                                  height: 12.0,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                            final photoSharingPostPostsRecord =
                                                                snapshot.data!;
                                                            return InkWell(
                                                              onTap: () async {
                                                                context
                                                                    .pushNamed(
                                                                  'PostDetails',
                                                                  queryParams: {
                                                                    'post':
                                                                        serializeParam(
                                                                      messageChatMessagesRecord
                                                                          .postRef,
                                                                      ParamType
                                                                          .DocumentReference,
                                                                    ),
                                                                  }.withoutNulls,
                                                                );
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xFFF5F5F5),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.0),
                                                                ),
                                                                child: FutureBuilder<
                                                                    UsersRecord>(
                                                                  future: UsersRecord
                                                                      .getDocumentOnce(
                                                                          photoSharingPostPostsRecord
                                                                              .postUser!),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    // Customize what your widget looks like when it's loading.
                                                                    if (!snapshot
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              12.0,
                                                                          height:
                                                                              12.0,
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                    final columnUsersRecord =
                                                                        snapshot
                                                                            .data!;
                                                                    return Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              16.0,
                                                                              8.0,
                                                                              16.0,
                                                                              8.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Align(
                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                                                                                  child: Container(
                                                                                    width: 37.0,
                                                                                    height: 37.0,
                                                                                    decoration: BoxDecoration(
                                                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                      image: DecorationImage(
                                                                                        fit: BoxFit.cover,
                                                                                        image: Image.network(
                                                                                          valueOrDefault<String>(
                                                                                            columnUsersRecord.photoUrl,
                                                                                            'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg',
                                                                                          ),
                                                                                        ).image,
                                                                                      ),
                                                                                      shape: BoxShape.circle,
                                                                                      border: Border.all(
                                                                                        color: FlutterFlowTheme.of(context).primaryColor,
                                                                                        width: 2.0,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                columnUsersRecord.username!.maybeHandleOverflow(
                                                                                  maxChars: 26,
                                                                                  replacement: '…',
                                                                                ),
                                                                                maxLines: 1,
                                                                                style: FlutterFlowTheme.of(context).bodyText1,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Image
                                                                            .network(
                                                                          photoSharingPostPostsRecord
                                                                              .postPhoto!,
                                                                          width:
                                                                              250.0,
                                                                          height:
                                                                              250.0,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              16.0,
                                                                              9.0,
                                                                              16.0,
                                                                              12.0),
                                                                          child:
                                                                              custom_widgets.PhotoCaption(
                                                                            width:
                                                                                218.0,
                                                                            height:
                                                                                17.0,
                                                                            name:
                                                                                columnUsersRecord.username!,
                                                                            caption:
                                                                                photoSharingPostPostsRecord.postCaption!,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      if (messageChatMessagesRecord.user !=
                                          currentUserReference)
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  15.0, 0.0, 15.0, 4.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.75,
                                                decoration: BoxDecoration(),
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      if ((messageChatMessagesRecord
                                                                  .postRef ==
                                                              null) &&
                                                          (messageChatMessagesRecord
                                                                  .commentRef ==
                                                              null))
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xFFF6F6F6),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              4.0),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              32.0),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              4.0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              32.0),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            10.0,
                                                                            16.0,
                                                                            10.0),
                                                                    child: Text(
                                                                      messageChatMessagesRecord
                                                                          .text!,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText1
                                                                          .override(
                                                                            fontFamily:
                                                                                'Inter',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            fontSize:
                                                                                15.0,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            lineHeight:
                                                                                1.5,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      if ((messageChatMessagesRecord
                                                                  .postRef !=
                                                              null) &&
                                                          (messageChatMessagesRecord
                                                                  .commentRef !=
                                                              null))
                                                        InkWell(
                                                          onTap: () async {
                                                            context.pushNamed(
                                                              'PostDetails',
                                                              queryParams: {
                                                                'post':
                                                                    serializeParam(
                                                                  messageChatMessagesRecord
                                                                      .postRef,
                                                                  ParamType
                                                                      .DocumentReference,
                                                                ),
                                                              }.withoutNulls,
                                                            );
                                                          },
                                                          child: Stack(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1.0, 1.0),
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            20.0),
                                                                child: StreamBuilder<
                                                                    PostsRecord>(
                                                                  stream: PostsRecord
                                                                      .getDocument(
                                                                          messageChatMessagesRecord
                                                                              .postRef!),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    // Customize what your widget looks like when it's loading.
                                                                    if (!snapshot
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              12.0,
                                                                          height:
                                                                              12.0,
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                    final postPhotoPostsRecord =
                                                                        snapshot
                                                                            .data!;
                                                                    return ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16.0),
                                                                      child: Image
                                                                          .network(
                                                                        postPhotoPostsRecord
                                                                            .postPhoto!,
                                                                        width:
                                                                            200.0,
                                                                        height:
                                                                            200.0,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            24.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: StreamBuilder<
                                                                    CommentsRecord>(
                                                                  stream: CommentsRecord
                                                                      .getDocument(
                                                                          messageChatMessagesRecord
                                                                              .commentRef!),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    // Customize what your widget looks like when it's loading.
                                                                    if (!snapshot
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              12.0,
                                                                          height:
                                                                              12.0,
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                    final postCommentCommentsRecord =
                                                                        snapshot
                                                                            .data!;
                                                                    return Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(0xFFF5F5F5),
                                                                            borderRadius:
                                                                                BorderRadius.circular(16.0),
                                                                          ),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                                                                                  child: FutureBuilder<UsersRecord>(
                                                                                    future: UsersRecord.getDocumentOnce(postCommentCommentsRecord.postUser!),
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
                                                                                      return Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Align(
                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                                                                                              child: Container(
                                                                                                width: 37.0,
                                                                                                height: 37.0,
                                                                                                decoration: BoxDecoration(
                                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                  image: DecorationImage(
                                                                                                    fit: BoxFit.cover,
                                                                                                    image: Image.network(
                                                                                                      valueOrDefault<String>(
                                                                                                        rowUsersRecord.photoUrl,
                                                                                                        'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg',
                                                                                                      ),
                                                                                                    ).image,
                                                                                                  ),
                                                                                                  shape: BoxShape.circle,
                                                                                                  border: Border.all(
                                                                                                    color: FlutterFlowTheme.of(context).primaryColor,
                                                                                                    width: 2.0,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: Column(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              children: [
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 9.0, 0.0, 0.0),
                                                                                                  child: custom_widgets.PhotoCaption(
                                                                                                    width: double.infinity,
                                                                                                    height: 17.0,
                                                                                                    name: valueOrDefault<String>(
                                                                                                      rowUsersRecord.username,
                                                                                                      'user',
                                                                                                    ),
                                                                                                    caption: postCommentCommentsRecord.comment!,
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ],
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
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      if ((messageChatMessagesRecord
                                                                  .postRef !=
                                                              null) &&
                                                          (messageChatMessagesRecord
                                                                  .commentRef ==
                                                              null))
                                                        StreamBuilder<
                                                            PostsRecord>(
                                                          stream: PostsRecord
                                                              .getDocument(
                                                                  messageChatMessagesRecord
                                                                      .postRef!),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Center(
                                                                child: SizedBox(
                                                                  width: 12.0,
                                                                  height: 12.0,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                            final photoSharingPostPostsRecord =
                                                                snapshot.data!;
                                                            return InkWell(
                                                              onTap: () async {
                                                                context
                                                                    .pushNamed(
                                                                  'PostDetails',
                                                                  queryParams: {
                                                                    'post':
                                                                        serializeParam(
                                                                      messageChatMessagesRecord
                                                                          .postRef,
                                                                      ParamType
                                                                          .DocumentReference,
                                                                    ),
                                                                  }.withoutNulls,
                                                                );
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xFFF5F5F5),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.0),
                                                                ),
                                                                child: FutureBuilder<
                                                                    UsersRecord>(
                                                                  future: UsersRecord
                                                                      .getDocumentOnce(
                                                                          photoSharingPostPostsRecord
                                                                              .postUser!),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    // Customize what your widget looks like when it's loading.
                                                                    if (!snapshot
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              12.0,
                                                                          height:
                                                                              12.0,
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                    final columnUsersRecord =
                                                                        snapshot
                                                                            .data!;
                                                                    return Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              16.0,
                                                                              8.0,
                                                                              16.0,
                                                                              8.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Align(
                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                                                                                  child: Container(
                                                                                    width: 37.0,
                                                                                    height: 37.0,
                                                                                    decoration: BoxDecoration(
                                                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                      image: DecorationImage(
                                                                                        fit: BoxFit.cover,
                                                                                        image: Image.network(
                                                                                          valueOrDefault<String>(
                                                                                            columnUsersRecord.photoUrl,
                                                                                            'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg',
                                                                                          ),
                                                                                        ).image,
                                                                                      ),
                                                                                      shape: BoxShape.circle,
                                                                                      border: Border.all(
                                                                                        color: FlutterFlowTheme.of(context).primaryColor,
                                                                                        width: 2.0,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                columnUsersRecord.username!.maybeHandleOverflow(
                                                                                  maxChars: 26,
                                                                                  replacement: '…',
                                                                                ),
                                                                                maxLines: 1,
                                                                                style: FlutterFlowTheme.of(context).bodyText1,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Image
                                                                            .network(
                                                                          photoSharingPostPostsRecord
                                                                              .postPhoto!,
                                                                          width:
                                                                              250.0,
                                                                          height:
                                                                              250.0,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              16.0,
                                                                              9.0,
                                                                              16.0,
                                                                              12.0),
                                                                          child:
                                                                              custom_widgets.PhotoCaption(
                                                                            width:
                                                                                218.0,
                                                                            height:
                                                                                17.0,
                                                                            name:
                                                                                columnUsersRecord.username!,
                                                                            caption:
                                                                                photoSharingPostPostsRecord.postCaption!,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            15.0, 0.0, 15.0, 24.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40.0),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 10.0,
                              sigmaY: 10.0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xCDF3F3F3),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    6.0, 6.0, 6.0, 6.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 1.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Container(
                                          width: 45.0,
                                          height: 45.0,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.network(
                                            valueOrDefault<String>(
                                              currentUserPhoto,
                                              'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 0.0, 0.0),
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional(1.0, 1.0),
                                          children: [
                                            TextFormField(
                                              controller:
                                                  _model.messageController,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1,
                                                hintText: 'Message...',
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00DADADA),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                ),
                                                contentPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(0.0, 8.0,
                                                            55.0, 8.0),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        lineHeight: 1.5,
                                                      ),
                                              maxLines: 5,
                                              minLines: 1,
                                              validator: _model
                                                  .messageControllerValidator
                                                  .asValidator(context),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 16.0, 15.0),
                                              child: StreamBuilder<ChatsRecord>(
                                                stream: ChatsRecord.getDocument(
                                                    widget.chat!),
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
                                                  final sendChatsRecord =
                                                      snapshot.data!;
                                                  return InkWell(
                                                    onTap: () async {
                                                      final chatMessagesCreateData =
                                                          createChatMessagesRecordData(
                                                        user:
                                                            currentUserReference,
                                                        chat: widget.chat,
                                                        text: _model
                                                            .messageController
                                                            .text,
                                                        timestamp:
                                                            getCurrentTimestamp,
                                                      );
                                                      var chatMessagesRecordReference =
                                                          ChatMessagesRecord
                                                              .collection
                                                              .doc();
                                                      await chatMessagesRecordReference
                                                          .set(
                                                              chatMessagesCreateData);
                                                      _model.message = ChatMessagesRecord
                                                          .getDocumentFromData(
                                                              chatMessagesCreateData,
                                                              chatMessagesRecordReference);

                                                      final chatsUpdateData = {
                                                        ...createChatsRecordData(
                                                          lastMessage: _model
                                                              .messageController
                                                              .text,
                                                          lastMessageTime:
                                                              getCurrentTimestamp,
                                                          lastMessageSentBy:
                                                              currentUserReference,
                                                        ),
                                                        'last_message_seen_by':
                                                            FieldValue
                                                                .arrayRemove([
                                                          sendChatsRecord
                                                                      .userA ==
                                                                  currentUserReference
                                                              ? sendChatsRecord
                                                                  .userB
                                                              : sendChatsRecord
                                                                  .userA
                                                        ]),
                                                      };
                                                      await widget.chat!.update(
                                                          chatsUpdateData);
                                                      setState(() {
                                                        _model.messageController
                                                            ?.clear();
                                                      });

                                                      setState(() {});
                                                    },
                                                    child: Text(
                                                      'Send',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryColor,
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
      ),
    );
  }
}
