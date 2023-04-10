import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'dart:async';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'search_model.dart';
export 'search_model.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget>
    with TickerProviderStateMixin {
  late SearchModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  final animationsMap = {
    'textOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 1.ms),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: Offset(50.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().update(() {
        FFAppState().imageSearchDummyToggle = true;
      });
    });

    if (!isWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        setState(() {
          _isKeyboardVisible = visible;
        });
      });
    }

    _model.searchFieldController ??= TextEditingController();

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
        automaticallyImplyLeading: false,
        title: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: StreamBuilder<List<UsersRecord>>(
                    stream: queryUsersRecord(),
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
                      List<UsersRecord> searchFieldUsersRecordList = snapshot
                          .data!
                          .where((u) => u.uid != currentUserUid)
                          .toList();
                      return Container(
                        width: 50.0,
                        child: TextFormField(
                          controller: _model.searchFieldController,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.searchFieldController',
                            Duration(milliseconds: 1000),
                            () async {
                              _model.timerSearchFieldActionsController.onExecute
                                  .add(StopWatchExecute.reset);

                              setState(() {
                                _model.simpleSearchResults1 = TextSearch(
                                  searchFieldUsersRecordList
                                      .map(
                                        (record) => TextSearchItem(record, [
                                          record.displayName!,
                                          record.username!
                                        ]),
                                      )
                                      .toList(),
                                )
                                    .search(valueOrDefault<String>(
                                      _model.searchFieldController.text,
                                      'a',
                                    ))
                                    .map((r) => r.object)
                                    .take(15)
                                    .toList();
                              });
                              FFAppState().update(() {
                                FFAppState().currentSearch =
                                    _model.searchFieldController.text;
                              });
                              _model.timerSearchFieldActionsController.onExecute
                                  .add(StopWatchExecute.start);
                            },
                          ),
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle:
                                FlutterFlowTheme.of(context).bodyText2.override(
                                      fontFamily: 'Inter',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                      lineHeight: 1.5,
                                    ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            filled: true,
                            fillColor: Color(0xFFF2F2F2),
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            prefixIcon: Icon(
                              FFIcons.ksearch,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 16.0,
                            ),
                            suffixIcon: _model
                                    .searchFieldController!.text.isNotEmpty
                                ? InkWell(
                                    onTap: () async {
                                      _model.searchFieldController?.clear();
                                      _model.timerSearchFieldActionsController
                                          .onExecute
                                          .add(StopWatchExecute.reset);

                                      setState(() {
                                        _model
                                            .simpleSearchResults1 = TextSearch(
                                          searchFieldUsersRecordList
                                              .map(
                                                (record) => TextSearchItem(
                                                    record, [
                                                  record.displayName!,
                                                  record.username!
                                                ]),
                                              )
                                              .toList(),
                                        )
                                            .search(valueOrDefault<String>(
                                              _model.searchFieldController.text,
                                              'a',
                                            ))
                                            .map((r) => r.object)
                                            .take(15)
                                            .toList();
                                      });
                                      FFAppState().update(() {
                                        FFAppState().currentSearch =
                                            _model.searchFieldController.text;
                                      });
                                      _model.timerSearchFieldActionsController
                                          .onExecute
                                          .add(StopWatchExecute.start);
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.clear,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 18.0,
                                    ),
                                  )
                                : null,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Inter',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                          validator: _model.searchFieldControllerValidator
                              .asValidator(context),
                        ),
                      );
                    },
                  ),
                ),
                if (_model.searchFieldController.text != null &&
                    _model.searchFieldController.text != '')
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          _model.searchFieldController?.clear();
                        });
                      },
                      child: Text(
                        'Cancel',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Inter',
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ).animateOnPageLoad(
                        animationsMap['textOnPageLoadAnimation']!),
                  ),
                StreamBuilder<List<PostsRecord>>(
                  stream: queryPostsRecord(
                    queryBuilder: (postsRecord) =>
                        postsRecord.where('deleted', isEqualTo: false),
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
                    List<PostsRecord> timerSearchFieldActionsPostsRecordList =
                        snapshot.data!;
                    return FlutterFlowTimer(
                      initialTime: _model.timerSearchFieldActionsMilliseconds,
                      getDisplayTime: (value) => StopWatchTimer.getDisplayTime(
                        value,
                        hours: false,
                        minute: false,
                        milliSecond: false,
                      ),
                      timer: _model.timerSearchFieldActionsController,
                      onChanged: (value, displayTime, shouldUpdate) {
                        _model.timerSearchFieldActionsMilliseconds = value;
                        _model.timerSearchFieldActionsValue = displayTime;
                        if (shouldUpdate) setState(() {});
                      },
                      onEnded: () async {
                        setState(() {
                          _model.simpleSearchResults2 = TextSearch(
                            timerSearchFieldActionsPostsRecordList
                                .map(
                                  (record) =>
                                      TextSearchItem(record, [record.labels!]),
                                )
                                .toList(),
                          )
                              .search(_model.searchFieldController.text)
                              .map((r) => r.object)
                              .take(15)
                              .toList();
                        });
                      },
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Inter',
                            color: Colors.white,
                            fontSize: 1.0,
                          ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        actions: [],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              if ((_model.searchFieldController.text != null &&
                      _model.searchFieldController.text != '') &&
                  !(isWeb
                      ? MediaQuery.of(context).viewInsets.bottom > 0
                      : _isKeyboardVisible))
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: DefaultTabController(
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
                                      fontSize: 16.0,
                                    ),
                            indicatorColor: Colors.black,
                            tabs: [
                              Tab(
                                text: 'Profiles',
                              ),
                              Tab(
                                text: 'Images',
                              ),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15.0, 0.0, 15.0, 0.0),
                                  child: Builder(
                                    builder: (context) {
                                      final searchUsers = _model
                                          .simpleSearchResults1
                                          .where((e) => !FFAppState()
                                              .taggedUsers
                                              .contains(e.reference))
                                          .toList();
                                      return Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children:
                                            List.generate(searchUsers.length,
                                                (searchUsersIndex) {
                                          final searchUsersItem =
                                              searchUsers[searchUsersIndex];
                                          return Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 12.0, 0.0, 0.0),
                                            child: InkWell(
                                              onTap: () async {
                                                final recentSearchesCreateData =
                                                    createRecentSearchesRecordData(
                                                  userRef:
                                                      searchUsersItem.reference,
                                                  timeSearched:
                                                      getCurrentTimestamp,
                                                );
                                                await RecentSearchesRecord
                                                        .createDoc(
                                                            currentUserReference!)
                                                    .set(
                                                        recentSearchesCreateData);

                                                context.pushNamed(
                                                  'ProfileOther',
                                                  queryParams: {
                                                    'username': serializeParam(
                                                      valueOrDefault<String>(
                                                        searchUsersItem
                                                            .username,
                                                        'user',
                                                      ),
                                                      ParamType.String,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
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
                                                        searchUsersItem
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
                                                          Text(
                                                            valueOrDefault<
                                                                String>(
                                                              searchUsersItem
                                                                  .displayName,
                                                              'user',
                                                            ),
                                                            maxLines: 1,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontSize:
                                                                      14.0,
                                                                ),
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
                                                              valueOrDefault<
                                                                  String>(
                                                                searchUsersItem
                                                                    .username,
                                                                'username',
                                                              ),
                                                              maxLines: 1,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
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
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                      );
                                    },
                                  ),
                                ),
                                Builder(
                                  builder: (context) {
                                    final searchimages = _model
                                        .simpleSearchResults2
                                        .toList()
                                        .take(15)
                                        .toList();
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
                                      scrollDirection: Axis.vertical,
                                      itemCount: searchimages.length,
                                      itemBuilder:
                                          (context, searchimagesIndex) {
                                        final searchimagesItem =
                                            searchimages[searchimagesIndex];
                                        return InkWell(
                                          onTap: () async {
                                            context.pushNamed(
                                              'PostDetails',
                                              queryParams: {
                                                'post': serializeParam(
                                                  searchimagesItem.reference,
                                                  ParamType.DocumentReference,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                          child: Hero(
                                            tag: searchimagesItem.postPhoto!,
                                            transitionOnUserGestures: true,
                                            child: Image.network(
                                              searchimagesItem.postPhoto!,
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if ((_model.searchFieldController.text == null ||
                      _model.searchFieldController.text == '') &&
                  (isWeb
                      ? MediaQuery.of(context).viewInsets.bottom > 0
                      : _isKeyboardVisible))
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                  child: StreamBuilder<List<RecentSearchesRecord>>(
                    stream: queryRecentSearchesRecord(
                      parent: currentUserReference,
                      queryBuilder: (recentSearchesRecord) =>
                          recentSearchesRecord.orderBy('time_searched',
                              descending: true),
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
                      List<RecentSearchesRecord>
                          recentSearchesRecentSearchesRecordList =
                          snapshot.data!;
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(
                            recentSearchesRecentSearchesRecordList.length,
                            (recentSearchesIndex) {
                          final recentSearchesRecentSearchesRecord =
                              recentSearchesRecentSearchesRecordList[
                                  recentSearchesIndex];
                          return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 12.0, 0.0, 0.0),
                            child: StreamBuilder<UsersRecord>(
                              stream: UsersRecord.getDocument(
                                  recentSearchesRecentSearchesRecord.userRef!),
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
                                final profileInfoUsersRecord = snapshot.data!;
                                return InkWell(
                                  onTap: () async {
                                    context.pushNamed(
                                      'ProfileOther',
                                      queryParams: {
                                        'username': serializeParam(
                                          profileInfoUsersRecord.username,
                                          ParamType.String,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 55.0,
                                        height: 55.0,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.network(
                                          valueOrDefault<String>(
                                            profileInfoUsersRecord.photoUrl,
                                            'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 0.0, 0.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                profileInfoUsersRecord
                                                    .displayName!,
                                                maxLines: 1,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          fontSize: 14.0,
                                                        ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 2.0, 0.0, 0.0),
                                                child: Text(
                                                  profileInfoUsersRecord
                                                      .username!,
                                                  maxLines: 1,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText2
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          await recentSearchesRecentSearchesRecord
                                              .reference
                                              .delete();
                                        },
                                        child: Icon(
                                          Icons.close_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),
              if ((_model.searchFieldController.text == null ||
                      _model.searchFieldController.text == '') &&
                  !(isWeb
                      ? MediaQuery.of(context).viewInsets.bottom > 0
                      : _isKeyboardVisible))
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: FutureBuilder<List<PostsRecord>>(
                            future: (_model.firestoreRequestCompleter ??=
                                    Completer<List<PostsRecord>>()
                                      ..complete(queryPostsRecordOnce(
                                        queryBuilder: (postsRecord) =>
                                            postsRecord.where('deleted',
                                                isEqualTo: false),
                                        limit: 18,
                                      )))
                                .future,
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
                              List<PostsRecord> photoGalleryPostsRecordList =
                                  snapshot.data!;
                              return RefreshIndicator(
                                onRefresh: () async {
                                  setState(() =>
                                      _model.firestoreRequestCompleter = null);
                                  await _model
                                      .waitForFirestoreRequestCompleter();
                                },
                                child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 1.0,
                                    mainAxisSpacing: 1.0,
                                    childAspectRatio: 1.0,
                                  ),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: photoGalleryPostsRecordList.length,
                                  itemBuilder: (context, photoGalleryIndex) {
                                    final photoGalleryPostsRecord =
                                        photoGalleryPostsRecordList[
                                            photoGalleryIndex];
                                    return InkWell(
                                      onTap: () async {
                                        context.pushNamed(
                                          'PostDetails',
                                          queryParams: {
                                            'post': serializeParam(
                                              photoGalleryPostsRecord.reference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Hero(
                                        tag: photoGalleryPostsRecord.postPhoto!,
                                        transitionOnUserGestures: true,
                                        child: Image.network(
                                          photoGalleryPostsRecord.postPhoto!,
                                          width: 100.0,
                                          height: 100.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
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
                                              FFIcons.ksearch1,
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
