import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/post_options/post_options_widget.dart';
import '/components/send_post/send_post_widget.dart';
import '/components/story/story_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'comments_model.dart';
export 'comments_model.dart';

class CommentsWidget extends StatefulWidget {
  const CommentsWidget({
    Key? key,
    this.post,
  }) : super(key: key);

  final DocumentReference? post;

  @override
  _CommentsWidgetState createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends State<CommentsWidget>
    with TickerProviderStateMixin {
  late CommentsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  final animationsMap = {
    'iconOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        ScaleEffect(
          curve: Curves.elasticOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.2,
          end: 1.0,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CommentsModel());

    _model.commentController ??= TextEditingController();

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
          'Comments',
          style: FlutterFlowTheme.of(context).title3.override(
                fontFamily: 'Inter',
                fontSize: 16.0,
              ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
            child: FutureBuilder<PostsRecord>(
              future: PostsRecord.getDocumentOnce(widget.post!),
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
                final stackPostsRecord = snapshot.data!;
                return Stack(
                  children: [
                    if (stackPostsRecord.postUser != currentUserReference)
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: InkWell(
                          onTap: () async {
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: SendPostWidget(
                                    post: widget.post,
                                  ),
                                );
                              },
                            ).then((value) => setState(() {}));
                          },
                          child: Icon(
                            FFIcons.kshare,
                            color: Colors.black,
                            size: 24.0,
                          ),
                        ),
                      ),
                    if (stackPostsRecord.postUser == currentUserReference)
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: InkWell(
                          onTap: () async {
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: PostOptionsWidget(
                                    post: stackPostsRecord,
                                  ),
                                );
                              },
                            ).then((value) => setState(() {}));
                          },
                          child: Icon(
                            FFIcons.kmore,
                            color: Colors.black,
                            size: 24.0,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: StreamBuilder<PostsRecord>(
            stream: PostsRecord.getDocument(widget.post!),
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
              final columnPostsRecord = snapshot.data!;
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    height: 0.5,
                    decoration: BoxDecoration(
                      color: Color(0xFFDADADA),
                    ),
                  ),
                  if (!columnPostsRecord.deleted!)
                    Expanded(
                      child: StreamBuilder<PostsRecord>(
                        stream: PostsRecord.getDocument(widget.post!),
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
                          final activeColumnPostsRecord = snapshot.data!;
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15.0, 0.0, 15.0, 12.0),
                                        child: FutureBuilder<UsersRecord>(
                                          future: UsersRecord.getDocumentOnce(
                                              activeColumnPostsRecord
                                                  .postUser!),
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
                                            final rowUsersRecord =
                                                snapshot.data!;
                                            return Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 12.0, 0.0),
                                                  child: Stack(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    children: [
                                                      StreamBuilder<
                                                          List<StoriesRecord>>(
                                                        stream:
                                                            queryStoriesRecord(
                                                          queryBuilder: (storiesRecord) => storiesRecord
                                                              .where('user',
                                                                  isEqualTo:
                                                                      rowUsersRecord
                                                                          .reference)
                                                              .where(
                                                                  'expire_time',
                                                                  isGreaterThan:
                                                                      getCurrentTimestamp),
                                                          singleRecord: true,
                                                        ),
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
                                                          List<StoriesRecord>
                                                              containerStoriesRecordList =
                                                              snapshot.data!;
                                                          // Return an empty Container when the item does not exist.
                                                          if (snapshot
                                                              .data!.isEmpty) {
                                                            return Container();
                                                          }
                                                          final containerStoriesRecord =
                                                              containerStoriesRecordList
                                                                      .isNotEmpty
                                                                  ? containerStoriesRecordList
                                                                      .first
                                                                  : null;
                                                          return InkWell(
                                                            onTap: () async {
                                                              await showModalBottomSheet(
                                                                isScrollControlled:
                                                                    true,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Padding(
                                                                    padding: MediaQuery.of(
                                                                            context)
                                                                        .viewInsets,
                                                                    child:
                                                                        StoryWidget(
                                                                      story:
                                                                          containerStoriesRecord,
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) =>
                                                                  setState(
                                                                      () {}));
                                                            },
                                                            child: Container(
                                                              width: 40.0,
                                                              height: 40.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: [
                                                                    Color(
                                                                        0xFF7C1E51),
                                                                    Color(
                                                                        0xFFDE0046),
                                                                    Color(
                                                                        0xFFF7A34B)
                                                                  ],
                                                                  stops: [
                                                                    0.0,
                                                                    0.5,
                                                                    1.0
                                                                  ],
                                                                  begin:
                                                                      AlignmentDirectional(
                                                                          1.0,
                                                                          -1.0),
                                                                  end:
                                                                      AlignmentDirectional(
                                                                          -1.0,
                                                                          1.0),
                                                                ),
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            if (rowUsersRecord
                                                                    .reference ==
                                                                currentUserReference) {
                                                              context.pushNamed(
                                                                  'Profile');
                                                            } else {
                                                              context.pushNamed(
                                                                'ProfileOther',
                                                                queryParams: {
                                                                  'username':
                                                                      serializeParam(
                                                                    rowUsersRecord
                                                                        .username,
                                                                    ParamType
                                                                        .String,
                                                                  ),
                                                                }.withoutNulls,
                                                              );
                                                            }
                                                          },
                                                          child: Container(
                                                            width: 37.0,
                                                            height: 37.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              image:
                                                                  DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: Image
                                                                    .network(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    rowUsersRecord
                                                                        .photoUrl,
                                                                    'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg',
                                                                  ),
                                                                ).image,
                                                              ),
                                                              shape: BoxShape
                                                                  .circle,
                                                              border:
                                                                  Border.all(
                                                                color: FlutterFlowTheme.of(
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
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      InkWell(
                                                        onTap: () async {
                                                          if (rowUsersRecord
                                                                  .reference ==
                                                              currentUserReference) {
                                                            context.pushNamed(
                                                                'Profile');
                                                          } else {
                                                            context.pushNamed(
                                                              'ProfileOther',
                                                              queryParams: {
                                                                'username':
                                                                    serializeParam(
                                                                  rowUsersRecord
                                                                      .username,
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                              }.withoutNulls,
                                                            );
                                                          }
                                                        },
                                                        child: custom_widgets
                                                            .PhotoCaption(
                                                          width:
                                                              double.infinity,
                                                          height: 17.0,
                                                          name: valueOrDefault<
                                                              String>(
                                                            rowUsersRecord
                                                                .username,
                                                            'user',
                                                          ),
                                                          caption:
                                                              activeColumnPostsRecord
                                                                  .postCaption!,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    6.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          dateTimeFormat(
                                                            'relative',
                                                            activeColumnPostsRecord
                                                                .timePosted!,
                                                            locale: FFLocalizations
                                                                    .of(context)
                                                                .languageCode,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText2
                                                              .override(
                                                                fontFamily:
                                                                    'Inter',
                                                                fontSize: 11.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
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
                                      Container(
                                        width: double.infinity,
                                        height: 0.5,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFDADADA),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                StreamBuilder<List<CommentsRecord>>(
                                  stream: queryCommentsRecord(
                                    parent: widget.post,
                                    queryBuilder: (commentsRecord) =>
                                        commentsRecord.orderBy('time_posted'),
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
                                    List<CommentsRecord>
                                        listViewCommentsRecordList =
                                        snapshot.data!;
                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                          listViewCommentsRecordList.length,
                                      itemBuilder: (context, listViewIndex) {
                                        final listViewCommentsRecord =
                                            listViewCommentsRecordList[
                                                listViewIndex];
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  15.0, 16.0, 15.0, 16.0),
                                          child: FutureBuilder<UsersRecord>(
                                            future: UsersRecord.getDocumentOnce(
                                                listViewCommentsRecord
                                                    .postUser!),
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
                                              final rowUsersRecord =
                                                  snapshot.data!;
                                              return Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                12.0, 0.0),
                                                    child: Stack(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      children: [
                                                        StreamBuilder<
                                                            List<
                                                                StoriesRecord>>(
                                                          stream:
                                                              queryStoriesRecord(
                                                            queryBuilder: (storiesRecord) => storiesRecord
                                                                .where('user',
                                                                    isEqualTo:
                                                                        rowUsersRecord
                                                                            .reference)
                                                                .where(
                                                                    'expire_time',
                                                                    isGreaterThan:
                                                                        getCurrentTimestamp),
                                                            singleRecord: true,
                                                          ),
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
                                                            List<StoriesRecord>
                                                                containerStoriesRecordList =
                                                                snapshot.data!;
                                                            // Return an empty Container when the item does not exist.
                                                            if (snapshot.data!
                                                                .isEmpty) {
                                                              return Container();
                                                            }
                                                            final containerStoriesRecord =
                                                                containerStoriesRecordList
                                                                        .isNotEmpty
                                                                    ? containerStoriesRecordList
                                                                        .first
                                                                    : null;
                                                            return InkWell(
                                                              onTap: () async {
                                                                await showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return Padding(
                                                                      padding: MediaQuery.of(
                                                                              context)
                                                                          .viewInsets,
                                                                      child:
                                                                          StoryWidget(
                                                                        story:
                                                                            containerStoriesRecord,
                                                                      ),
                                                                    );
                                                                  },
                                                                ).then((value) =>
                                                                    setState(
                                                                        () {}));
                                                              },
                                                              child: Container(
                                                                width: 40.0,
                                                                height: 40.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  gradient:
                                                                      LinearGradient(
                                                                    colors: [
                                                                      Color(
                                                                          0xFF7C1E51),
                                                                      Color(
                                                                          0xFFDE0046),
                                                                      Color(
                                                                          0xFFF7A34B)
                                                                    ],
                                                                    stops: [
                                                                      0.0,
                                                                      0.5,
                                                                      1.0
                                                                    ],
                                                                    begin:
                                                                        AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0),
                                                                    end: AlignmentDirectional(
                                                                        -1.0,
                                                                        1.0),
                                                                  ),
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: InkWell(
                                                            onTap: () async {
                                                              if (rowUsersRecord
                                                                      .reference ==
                                                                  currentUserReference) {
                                                                context.pushNamed(
                                                                    'Profile');
                                                              } else {
                                                                context
                                                                    .pushNamed(
                                                                  'ProfileOther',
                                                                  queryParams: {
                                                                    'username':
                                                                        serializeParam(
                                                                      rowUsersRecord
                                                                          .username,
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                  }.withoutNulls,
                                                                );
                                                              }
                                                            },
                                                            child: Container(
                                                              width: 37.0,
                                                              height: 37.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                image:
                                                                    DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: Image
                                                                      .network(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      rowUsersRecord
                                                                          .photoUrl,
                                                                      'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg',
                                                                    ),
                                                                  ).image,
                                                                ),
                                                                shape: BoxShape
                                                                    .circle,
                                                                border:
                                                                    Border.all(
                                                                  color: FlutterFlowTheme.of(
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
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            InkWell(
                                                              onTap: () async {
                                                                if (rowUsersRecord
                                                                        .reference ==
                                                                    currentUserReference) {
                                                                  context.pushNamed(
                                                                      'Profile');
                                                                } else {
                                                                  context
                                                                      .pushNamed(
                                                                    'ProfileOther',
                                                                    queryParams:
                                                                        {
                                                                      'username':
                                                                          serializeParam(
                                                                        rowUsersRecord
                                                                            .username,
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                    }.withoutNulls,
                                                                  );
                                                                }
                                                              },
                                                              child: custom_widgets
                                                                  .PhotoCaption(
                                                                width: double
                                                                    .infinity,
                                                                height: 17.0,
                                                                name:
                                                                    valueOrDefault<
                                                                        String>(
                                                                  rowUsersRecord
                                                                      .username,
                                                                  'user',
                                                                ),
                                                                caption:
                                                                    valueOrDefault<
                                                                        String>(
                                                                  listViewCommentsRecord
                                                                      .comment,
                                                                  'No comment',
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      6.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Text(
                                                                dateTimeFormat(
                                                                  'relative',
                                                                  listViewCommentsRecord
                                                                      .timePosted!,
                                                                  locale: FFLocalizations.of(
                                                                          context)
                                                                      .languageCode,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText2
                                                                    .override(
                                                                      fontFamily:
                                                                          'Inter',
                                                                      fontSize:
                                                                          11.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            18.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Text(
                                                                  '${valueOrDefault<String>(
                                                                    formatNumber(
                                                                      listViewCommentsRecord
                                                                          .likes!
                                                                          .toList()
                                                                          .length,
                                                                      formatType:
                                                                          FormatType
                                                                              .compact,
                                                                    ),
                                                                    '0',
                                                                  )}${listViewCommentsRecord.likes!.toList().length == 1 ? ' like' : ' likes'}',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyText2
                                                                      .override(
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontSize:
                                                                            11.5,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            18.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    await showModalBottomSheet(
                                                                      isScrollControlled:
                                                                          true,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return Padding(
                                                                          padding:
                                                                              MediaQuery.of(context).viewInsets,
                                                                          child:
                                                                              SendPostWidget(
                                                                            post:
                                                                                widget.post,
                                                                            comment:
                                                                                listViewCommentsRecord.reference,
                                                                          ),
                                                                        );
                                                                      },
                                                                    ).then((value) =>
                                                                        setState(
                                                                            () {}));
                                                                  },
                                                                  child: Text(
                                                                    'Send',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText2
                                                                        .override(
                                                                          fontFamily:
                                                                              'Inter',
                                                                          fontSize:
                                                                              11.5,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              if ((listViewCommentsRecord
                                                                          .postUser ==
                                                                      currentUserReference) ||
                                                                  (activeColumnPostsRecord
                                                                          .postUser ==
                                                                      currentUserReference))
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          18.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      await listViewCommentsRecord
                                                                          .reference
                                                                          .delete();

                                                                      final postsUpdateData =
                                                                          {
                                                                        'num_comments':
                                                                            FieldValue.increment(-(1)),
                                                                      };
                                                                      await activeColumnPostsRecord
                                                                          .reference
                                                                          .update(
                                                                              postsUpdateData);
                                                                    },
                                                                    child: Text(
                                                                      'Delete',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText2
                                                                          .override(
                                                                            fontFamily:
                                                                                'Inter',
                                                                            fontSize:
                                                                                11.5,
                                                                            fontWeight:
                                                                                FontWeight.w600,
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
                                                  Stack(
                                                    children: [
                                                      if (!listViewCommentsRecord
                                                          .likes!
                                                          .toList()
                                                          .contains(
                                                              currentUserReference))
                                                        InkWell(
                                                          onTap: () async {
                                                            final commentsUpdateData =
                                                                {
                                                              'likes': FieldValue
                                                                  .arrayUnion([
                                                                currentUserReference
                                                              ]),
                                                            };
                                                            await listViewCommentsRecord
                                                                .reference
                                                                .update(
                                                                    commentsUpdateData);
                                                            HapticFeedback
                                                                .lightImpact();
                                                            if (activeColumnPostsRecord
                                                                    .postUser !=
                                                                currentUserReference) {
                                                              final notificationsCreateData =
                                                                  createNotificationsRecordData(
                                                                notificationType:
                                                                    'Comment_Like',
                                                                userRef:
                                                                    currentUserReference,
                                                                postRef:
                                                                    widget.post,
                                                                timeCreated:
                                                                    getCurrentTimestamp,
                                                                commentRef:
                                                                    listViewCommentsRecord
                                                                        .reference,
                                                              );
                                                              var notificationsRecordReference =
                                                                  NotificationsRecord
                                                                      .createDoc(
                                                                          rowUsersRecord
                                                                              .reference);
                                                              await notificationsRecordReference
                                                                  .set(
                                                                      notificationsCreateData);
                                                              _model.notification =
                                                                  NotificationsRecord
                                                                      .getDocumentFromData(
                                                                          notificationsCreateData,
                                                                          notificationsRecordReference);

                                                              final usersUpdateData =
                                                                  {
                                                                'unreadNotifications':
                                                                    FieldValue
                                                                        .arrayUnion([
                                                                  _model
                                                                      .notification!
                                                                      .reference
                                                                ]),
                                                              };
                                                              await rowUsersRecord
                                                                  .reference
                                                                  .update(
                                                                      usersUpdateData);
                                                            }

                                                            setState(() {});
                                                          },
                                                          child: Icon(
                                                            FFIcons.kheart,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                            size: 14.0,
                                                          ),
                                                        ),
                                                      if (listViewCommentsRecord
                                                          .likes!
                                                          .toList()
                                                          .contains(
                                                              currentUserReference))
                                                        InkWell(
                                                          onTap: () async {
                                                            final commentsUpdateData =
                                                                {
                                                              'likes': FieldValue
                                                                  .arrayRemove([
                                                                currentUserReference
                                                              ]),
                                                            };
                                                            await listViewCommentsRecord
                                                                .reference
                                                                .update(
                                                                    commentsUpdateData);
                                                          },
                                                          child: Icon(
                                                            FFIcons.kheart1,
                                                            color: Color(
                                                                0xFFFF4963),
                                                            size: 14.0,
                                                          ),
                                                        ).animateOnPageLoad(
                                                            animationsMap[
                                                                'iconOnPageLoadAnimation']!),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  if (!columnPostsRecord.deleted!)
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 16.0, 15.0, 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '🥳',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Inter',
                                      fontSize: 28.0,
                                    ),
                              ),
                              Text(
                                '🤩',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Inter',
                                      fontSize: 28.0,
                                    ),
                              ),
                              Text(
                                '🎉',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Inter',
                                      fontSize: 28.0,
                                    ),
                              ),
                              Text(
                                '💯',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Inter',
                                      fontSize: 28.0,
                                    ),
                              ),
                              Text(
                                '🔥',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Inter',
                                      fontSize: 28.0,
                                    ),
                              ),
                              Text(
                                '🚀',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Inter',
                                      fontSize: 28.0,
                                    ),
                              ),
                              Text(
                                '😂',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Inter',
                                      fontSize: 28.0,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 0.0, 15.0, 24.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.end,
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
                                    alignment: AlignmentDirectional(1.0, 1.0),
                                    children: [
                                      AuthUserStreamWidget(
                                        builder: (context) => TextFormField(
                                          controller: _model.commentController,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyText1,
                                            hintText:
                                                'Add a comment as ${valueOrDefault(currentUserDocument?.username, '')}...',
                                            hintStyle: FlutterFlowTheme.of(
                                                    context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Inter',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFDADADA),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            ),
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 16.0, 50.0, 16.0),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.normal,
                                                lineHeight: 1.5,
                                              ),
                                          maxLines: 5,
                                          minLines: 1,
                                          validator: _model
                                              .commentControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 16.0, 17.0),
                                        child: FutureBuilder<PostsRecord>(
                                          future: PostsRecord.getDocumentOnce(
                                              widget.post!),
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
                                            final textPostsRecord =
                                                snapshot.data!;
                                            return InkWell(
                                              onTap: () async {
                                                final commentsCreateData = {
                                                  ...createCommentsRecordData(
                                                    postUser:
                                                        currentUserReference,
                                                    timePosted:
                                                        getCurrentTimestamp,
                                                    comment: _model
                                                        .commentController.text,
                                                  ),
                                                  'likes':
                                                      FFAppState().emptyList,
                                                };
                                                var commentsRecordReference =
                                                    CommentsRecord.createDoc(
                                                        widget.post!);
                                                await commentsRecordReference
                                                    .set(commentsCreateData);
                                                _model.comment = CommentsRecord
                                                    .getDocumentFromData(
                                                        commentsCreateData,
                                                        commentsRecordReference);

                                                final postsUpdateData = {
                                                  'num_comments':
                                                      FieldValue.increment(1),
                                                };
                                                await widget.post!
                                                    .update(postsUpdateData);
                                                setState(() {
                                                  _model.commentController
                                                      ?.clear();
                                                });

                                                setState(() {});
                                              },
                                              child: Text(
                                                'Post',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryColor,
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
                      ],
                    ),
                  if (columnPostsRecord.deleted ?? true)
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                48.0, 0.0, 48.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sorry, this post isn\'t\navailable.',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'Inter',
                                        lineHeight: 1.2,
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 24.0, 0.0, 0.0),
                                  child: Text(
                                    'The link you followed may be broken, or the post may have been removed.',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Inter',
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal,
                                          lineHeight: 1.5,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 24.0, 0.0, 0.0),
                                  child: InkWell(
                                    onTap: () async {
                                      context.pop();
                                    },
                                    child: Text(
                                      'Go back.',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Inter',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryColor,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.normal,
                                            lineHeight: 1.5,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
