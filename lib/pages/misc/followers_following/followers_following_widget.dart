import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/follower_componant/follower_componant_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'followers_following_model.dart';
export 'followers_following_model.dart';

class FollowersFollowingWidget extends StatefulWidget {
  const FollowersFollowingWidget({Key? key}) : super(key: key);

  @override
  _FollowersFollowingWidgetState createState() =>
      _FollowersFollowingWidgetState();
}

class _FollowersFollowingWidgetState extends State<FollowersFollowingWidget> {
  late FollowersFollowingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FollowersFollowingModel());

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
        title: AuthUserStreamWidget(
          builder: (context) => Text(
            valueOrDefault(currentUserDocument?.username, ''),
            style: FlutterFlowTheme.of(context).subtitle1.override(
                  fontFamily: 'Inter',
                  fontSize: 16.0,
                ),
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 1.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: StreamBuilder<List<FollowersRecord>>(
              stream: queryFollowersRecord(
                parent: currentUserReference,
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
                List<FollowersRecord> tabBarFollowersRecordList =
                    snapshot.data!;
                final tabBarFollowersRecord =
                    tabBarFollowersRecordList.isNotEmpty
                        ? tabBarFollowersRecordList.first
                        : null;
                return DefaultTabController(
                  length: 2,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: Colors.black,
                        unselectedLabelColor: Color(0x80000000),
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyText1.override(
                                  fontFamily: 'Inter',
                                  fontSize: 15.0,
                                ),
                        indicatorColor: Colors.black,
                        indicatorWeight: 2.0,
                        tabs: [
                          Tab(
                            text: valueOrDefault<String>(
                              '${formatNumber(
                                tabBarFollowersRecord!.userRefs!
                                    .toList()
                                    .length,
                                formatType: FormatType.compact,
                              )} Followers',
                              '0 Followers',
                            ),
                          ),
                          AuthUserStreamWidget(
                            builder: (context) => Tab(
                              text: valueOrDefault<String>(
                                '${formatNumber(
                                  (currentUserDocument?.following?.toList() ??
                                          [])
                                      .length,
                                  formatType: FormatType.compact,
                                )} Following',
                                '0 Followers',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            KeepAliveWidgetWrapper(
                              builder: (context) => Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 0.0, 15.0, 0.0),
                                child: Builder(
                                  builder: (context) {
                                    final followers = tabBarFollowersRecord!
                                        .userRefs!
                                        .toList();
                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: followers.length,
                                      itemBuilder: (context, followersIndex) {
                                        final followersItem =
                                            followers[followersIndex];
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 12.0, 0.0, 0.0),
                                          child: StreamBuilder<UsersRecord>(
                                            stream: UsersRecord.getDocument(
                                                followersItem),
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
                                              return InkWell(
                                                onTap: () async {
                                                  if (rowUsersRecord
                                                          .reference ==
                                                      currentUserReference) {
                                                    context
                                                        .pushNamed('Profile');
                                                  } else {
                                                    context.pushNamed(
                                                      'ProfileOther',
                                                      queryParams: {
                                                        'username':
                                                            serializeParam(
                                                          rowUsersRecord
                                                              .username,
                                                          ParamType.String,
                                                        ),
                                                      }.withoutNulls,
                                                    );
                                                  }
                                                },
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: 55.0,
                                                      height: 55.0,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.network(
                                                        valueOrDefault<String>(
                                                          rowUsersRecord
                                                              .photoUrl,
                                                          'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg',
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    12.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    rowUsersRecord
                                                                        .username,
                                                                    'user',
                                                                  ).maybeHandleOverflow(
                                                                    maxChars:
                                                                        12,
                                                                    replacement:
                                                                        '…',
                                                                  ),
                                                                  maxLines: 1,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyText1
                                                                      .override(
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontSize:
                                                                            14.0,
                                                                      ),
                                                                ),
                                                                if (!(currentUserDocument
                                                                            ?.following
                                                                            ?.toList() ??
                                                                        [])
                                                                    .contains(
                                                                        rowUsersRecord
                                                                            .reference))
                                                                  AuthUserStreamWidget(
                                                                    builder:
                                                                        (context) =>
                                                                            Text(
                                                                      '  •  ',
                                                                      maxLines:
                                                                          1,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText1
                                                                          .override(
                                                                            fontFamily:
                                                                                'Inter',
                                                                            fontSize:
                                                                                14.0,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                if (!(currentUserDocument
                                                                            ?.following
                                                                            ?.toList() ??
                                                                        [])
                                                                    .contains(
                                                                        rowUsersRecord
                                                                            .reference))
                                                                  AuthUserStreamWidget(
                                                                    builder: (context) =>
                                                                        StreamBuilder<
                                                                            List<FollowersRecord>>(
                                                                      stream:
                                                                          queryFollowersRecord(
                                                                        parent:
                                                                            rowUsersRecord.reference,
                                                                        singleRecord:
                                                                            true,
                                                                      ),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        // Customize what your widget looks like when it's loading.
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return Center(
                                                                            child:
                                                                                SizedBox(
                                                                              width: 12.0,
                                                                              height: 12.0,
                                                                              child: CircularProgressIndicator(
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }
                                                                        List<FollowersRecord>
                                                                            textFollowersRecordList =
                                                                            snapshot.data!;
                                                                        final textFollowersRecord = textFollowersRecordList.isNotEmpty
                                                                            ? textFollowersRecordList.first
                                                                            : null;
                                                                        return InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            final usersUpdateData =
                                                                                {
                                                                              'following': FieldValue.arrayUnion([
                                                                                rowUsersRecord.reference
                                                                              ]),
                                                                            };
                                                                            await currentUserReference!.update(usersUpdateData);

                                                                            final followersUpdateData =
                                                                                {
                                                                              'userRefs': FieldValue.arrayUnion([
                                                                                currentUserReference
                                                                              ]),
                                                                            };
                                                                            await textFollowersRecord!.reference.update(followersUpdateData);
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'Follow',
                                                                            maxLines:
                                                                                1,
                                                                            style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                  fontFamily: 'Inter',
                                                                                  color: FlutterFlowTheme.of(context).secondaryColor,
                                                                                  fontSize: 14.0,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          2.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                rowUsersRecord
                                                                    .displayName!,
                                                                maxLines: 1,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText2
                                                                    .override(
                                                                      fontFamily:
                                                                          'Inter',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  6.0,
                                                                  0.0),
                                                      child: StreamBuilder<
                                                          List<
                                                              FollowersRecord>>(
                                                        stream:
                                                            queryFollowersRecord(
                                                          parent: rowUsersRecord
                                                              .reference,
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
                                                          List<FollowersRecord>
                                                              containerFollowersRecordList =
                                                              snapshot.data!;
                                                          final containerFollowersRecord =
                                                              containerFollowersRecordList
                                                                      .isNotEmpty
                                                                  ? containerFollowersRecordList
                                                                      .first
                                                                  : null;
                                                          return InkWell(
                                                            onTap: () async {
                                                              final usersUpdateData =
                                                                  {
                                                                'following':
                                                                    FieldValue
                                                                        .arrayRemove([
                                                                  currentUserReference
                                                                ]),
                                                              };
                                                              await rowUsersRecord
                                                                  .reference
                                                                  .update(
                                                                      usersUpdateData);

                                                              final followersUpdateData =
                                                                  {
                                                                'userRefs':
                                                                    FieldValue
                                                                        .arrayRemove([
                                                                  rowUsersRecord
                                                                      .reference
                                                                ]),
                                                              };
                                                              await tabBarFollowersRecord!
                                                                  .reference
                                                                  .update(
                                                                      followersUpdateData);
                                                            },
                                                            child: Container(
                                                              width: 90.0,
                                                              height: 35.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFFEFEFEF),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              child: Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          8.0,
                                                                          6.0,
                                                                          8.0,
                                                                          6.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        'Remove',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Inter',
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
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            KeepAliveWidgetWrapper(
                              builder: (context) => Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 0.0, 15.0, 0.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => Builder(
                                    builder: (context) {
                                      final following = (currentUserDocument
                                                  ?.following
                                                  ?.toList() ??
                                              [])
                                          .toList();
                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: following.length,
                                        itemBuilder: (context, followingIndex) {
                                          final followingItem =
                                              following[followingIndex];
                                          return FollowerComponantWidget(
                                            key: Key(
                                                'Keysex_${followingIndex}_of_${following.length}'),
                                            users: followingItem,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
