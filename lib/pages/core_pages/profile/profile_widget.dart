import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/components/story/story_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_media.dart';
import 'dart:async';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'profile_model.dart';
export 'profile_model.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late ProfileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileModel());

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
        title: AuthUserStreamWidget(
          builder: (context) => Text(
            valueOrDefault<String>(
              valueOrDefault(currentUserDocument?.username, ''),
              'user',
            ),
            style: FlutterFlowTheme.of(context).title3.override(
                  fontFamily: 'Inter',
                  fontSize: 24.0,
                ),
          ),
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 23.0, 0.0),
                child: InkWell(
                  onTap: () async {
                    FFAppState().update(() {
                      FFAppState().uploadPhoto = '';
                      FFAppState().taggedUsers = [];
                    });
                    FFAppState().update(() {
                      FFAppState().location = '';
                      FFAppState().calltoactionenabled = false;
                    });
                    FFAppState().update(() {
                      FFAppState().calltoactiontext = '';
                      FFAppState().calltoactionurl = '';
                    });
                    final selectedMedia = await selectMedia(
                      mediaSource: MediaSource.photoGallery,
                      multiImage: false,
                    );
                    if (selectedMedia != null &&
                        selectedMedia.every((m) =>
                            validateFileFormat(m.storagePath, context))) {
                      setState(() => _model.isMediaUploading1 = true);
                      var selectedUploadedFiles = <FFUploadedFile>[];
                      var downloadUrls = <String>[];
                      try {
                        showUploadMessage(
                          context,
                          'Uploading file...',
                          showLoading: true,
                        );
                        selectedUploadedFiles = selectedMedia
                            .map((m) => FFUploadedFile(
                                  name: m.storagePath.split('/').last,
                                  bytes: m.bytes,
                                  height: m.dimensions?.height,
                                  width: m.dimensions?.width,
                                ))
                            .toList();

                        downloadUrls = (await Future.wait(
                          selectedMedia.map(
                            (m) async =>
                                await uploadData(m.storagePath, m.bytes),
                          ),
                        ))
                            .where((u) => u != null)
                            .map((u) => u!)
                            .toList();
                      } finally {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        _model.isMediaUploading1 = false;
                      }
                      if (selectedUploadedFiles.length ==
                              selectedMedia.length &&
                          downloadUrls.length == selectedMedia.length) {
                        setState(() {
                          _model.uploadedLocalFile1 =
                              selectedUploadedFiles.first;
                          _model.uploadedFileUrl1 = downloadUrls.first;
                        });
                        showUploadMessage(context, 'Success!');
                      } else {
                        setState(() {});
                        showUploadMessage(context, 'Failed to upload media');
                        return;
                      }
                    }

                    if (_model.uploadedFileUrl1 != null &&
                        _model.uploadedFileUrl1 != '') {
                      FFAppState().update(() {
                        FFAppState().uploadPhoto = _model.uploadedFileUrl1;
                      });

                      context.pushNamed(
                        'NewPost',
                        extra: <String, dynamic>{
                          kTransitionInfoKey: TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.leftToRight,
                          ),
                        },
                      );
                    }
                  },
                  child: Icon(
                    FFIcons.kadd,
                    color: Colors.black,
                    size: 28.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 23.0, 0.0),
                child: InkWell(
                  onTap: () async {
                    GoRouter.of(context).prepareAuthEvent();
                    await signOut();

                    context.goNamedAuth('SignUp', mounted);
                  },
                  child: Icon(
                    Icons.logout,
                    color: Colors.black,
                    size: 26.0,
                  ),
                ),
              ),
            ],
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
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: SingleChildScrollView(
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
                                child: StreamBuilder<List<StoriesRecord>>(
                                  stream: queryStoriesRecord(
                                    queryBuilder: (storiesRecord) =>
                                        storiesRecord
                                            .where('user',
                                                isEqualTo: currentUserReference)
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
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    }
                                    List<StoriesRecord> stackStoriesRecordList =
                                        snapshot.data!;
                                    final stackStoriesRecord =
                                        stackStoriesRecordList.isNotEmpty
                                            ? stackStoriesRecordList.first
                                            : null;
                                    return Container(
                                      width: 100.0,
                                      height: 100.0,
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional(1.0, 1.0),
                                        children: [
                                          if (stackStoriesRecord != null)
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: InkWell(
                                                onTap: () async {
                                                  await showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder: (context) {
                                                      return Padding(
                                                        padding: MediaQuery.of(
                                                                context)
                                                            .viewInsets,
                                                        child: StoryWidget(
                                                          story:
                                                              stackStoriesRecord,
                                                        ),
                                                      );
                                                    },
                                                  ).then((value) =>
                                                      setState(() {}));
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
                                                      begin:
                                                          AlignmentDirectional(
                                                              1.0, -1.0),
                                                      end: AlignmentDirectional(
                                                          -1.0, 1.0),
                                                    ),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: AuthUserStreamWidget(
                                              builder: (context) => InkWell(
                                                onTap: () async {
                                                  if (stackStoriesRecord !=
                                                      null) {
                                                    showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      context: context,
                                                      builder: (context) {
                                                        return Padding(
                                                          padding:
                                                              MediaQuery.of(
                                                                      context)
                                                                  .viewInsets,
                                                          child: StoryWidget(
                                                            story:
                                                                stackStoriesRecord,
                                                          ),
                                                        );
                                                      },
                                                    ).then((value) =>
                                                        setState(() {}));

                                                    await Future.delayed(
                                                        const Duration(
                                                            milliseconds:
                                                                5000));
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                child: Container(
                                                  width: 93.0,
                                                  height: 93.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: Image.network(
                                                        valueOrDefault<String>(
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
                                                      width: 3.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (!(stackStoriesRecord != null))
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.0, 1.0),
                                              child: InkWell(
                                                onTap: () async {
                                                  final selectedMedia =
                                                      await selectMediaWithSourceBottomSheet(
                                                    context: context,
                                                    imageQuality: 80,
                                                    allowPhoto: true,
                                                    pickerFontFamily: 'Inter',
                                                  );
                                                  if (selectedMedia != null &&
                                                      selectedMedia.every((m) =>
                                                          validateFileFormat(
                                                              m.storagePath,
                                                              context))) {
                                                    setState(() => _model
                                                            .isMediaUploading2 =
                                                        true);
                                                    var selectedUploadedFiles =
                                                        <FFUploadedFile>[];
                                                    var downloadUrls =
                                                        <String>[];
                                                    try {
                                                      showUploadMessage(
                                                        context,
                                                        'Uploading file...',
                                                        showLoading: true,
                                                      );
                                                      selectedUploadedFiles =
                                                          selectedMedia
                                                              .map((m) =>
                                                                  FFUploadedFile(
                                                                    name: m
                                                                        .storagePath
                                                                        .split(
                                                                            '/')
                                                                        .last,
                                                                    bytes:
                                                                        m.bytes,
                                                                    height: m
                                                                        .dimensions
                                                                        ?.height,
                                                                    width: m
                                                                        .dimensions
                                                                        ?.width,
                                                                  ))
                                                              .toList();

                                                      downloadUrls =
                                                          (await Future.wait(
                                                        selectedMedia.map(
                                                          (m) async =>
                                                              await uploadData(
                                                                  m.storagePath,
                                                                  m.bytes),
                                                        ),
                                                      ))
                                                              .where((u) =>
                                                                  u != null)
                                                              .map((u) => u!)
                                                              .toList();
                                                    } finally {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .hideCurrentSnackBar();
                                                      _model.isMediaUploading2 =
                                                          false;
                                                    }
                                                    if (selectedUploadedFiles
                                                                .length ==
                                                            selectedMedia
                                                                .length &&
                                                        downloadUrls.length ==
                                                            selectedMedia
                                                                .length) {
                                                      setState(() {
                                                        _model.uploadedLocalFile2 =
                                                            selectedUploadedFiles
                                                                .first;
                                                        _model.uploadedFileUrl2 =
                                                            downloadUrls.first;
                                                      });
                                                      showUploadMessage(
                                                          context, 'Success!');
                                                    } else {
                                                      setState(() {});
                                                      showUploadMessage(context,
                                                          'Failed to upload media');
                                                      return;
                                                    }
                                                  }

                                                  if (_model.uploadedFileUrl2 !=
                                                          null &&
                                                      _model.uploadedFileUrl2 !=
                                                          '') {
                                                    final storiesCreateData = {
                                                      ...createStoriesRecordData(
                                                        user:
                                                            currentUserReference,
                                                        storyPhoto: _model
                                                            .uploadedFileUrl2,
                                                        timeCreated:
                                                            getCurrentTimestamp,
                                                        expireTime: functions
                                                            .tomorrowTime(
                                                                getCurrentTimestamp),
                                                      ),
                                                      'views': FFAppState()
                                                          .emptyList,
                                                    };
                                                    await StoriesRecord
                                                        .collection
                                                        .doc()
                                                        .set(storiesCreateData);
                                                  }
                                                },
                                                child: Container(
                                                  width: 30.0,
                                                  height: 30.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryColor,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      width: 3.0,
                                                    ),
                                                  ),
                                                  child: Icon(
                                                    Icons.add_rounded,
                                                    color: Colors.white,
                                                    size: 16.0,
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
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 0.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            StreamBuilder<List<PostsRecord>>(
                                              stream: queryPostsRecord(
                                                queryBuilder: (postsRecord) =>
                                                    postsRecord.where(
                                                        'post_user',
                                                        isEqualTo:
                                                            currentUserReference),
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
                                                  style: FlutterFlowTheme.of(
                                                          context)
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
                                                  .fromSTEB(0.0, 2.0, 0.0, 0.0),
                                              child: Text(
                                                'Posts',
                                                style:
                                                    FlutterFlowTheme.of(context)
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
                                          context
                                              .pushNamed('FollowersFollowing');
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            StreamBuilder<
                                                List<FollowersRecord>>(
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
                                                );
                                              },
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 2.0, 0.0, 0.0),
                                              child: Text(
                                                'Followers',
                                                style:
                                                    FlutterFlowTheme.of(context)
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
                                          context
                                              .pushNamed('FollowersFollowing');
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            AuthUserStreamWidget(
                                              builder: (context) => Text(
                                                valueOrDefault<String>(
                                                  formatNumber(
                                                    (currentUserDocument
                                                                ?.following
                                                                ?.toList() ??
                                                            [])
                                                        .length,
                                                    formatType:
                                                        FormatType.compact,
                                                  ),
                                                  '0',
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          fontSize: 17.0,
                                                        ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 2.0, 0.0, 0.0),
                                              child: Text(
                                                'Following',
                                                style:
                                                    FlutterFlowTheme.of(context)
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
                        if (currentUserDisplayName != null &&
                            currentUserDisplayName != '')
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.0, 6.0, 0.0, 0.0),
                            child: AuthUserStreamWidget(
                              builder: (context) => Text(
                                currentUserDisplayName,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Inter',
                                      fontSize: 15.0,
                                    ),
                              ),
                            ),
                          ),
                        if (valueOrDefault(currentUserDocument?.bio, '') !=
                                null &&
                            valueOrDefault(currentUserDocument?.bio, '') != '')
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.0, 4.0, 0.0, 0.0),
                            child: AuthUserStreamWidget(
                              builder: (context) => Text(
                                valueOrDefault(currentUserDocument?.bio, ''),
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Inter',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                          ),
                        if (valueOrDefault(currentUserDocument?.website, '') !=
                                null &&
                            valueOrDefault(currentUserDocument?.website, '') !=
                                '')
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.0, 4.0, 0.0, 0.0),
                            child: AuthUserStreamWidget(
                              builder: (context) => InkWell(
                                onTap: () async {
                                  await launchURL(valueOrDefault(
                                      currentUserDocument?.website, ''));
                                },
                                child: Text(
                                  valueOrDefault(
                                      currentUserDocument?.website, ''),
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
                          ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 15.0, 15.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    context.pushNamed(
                                      'EditProfile',
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.bottomToTop,
                                        ),
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 35.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFEFEFEF),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 6.0, 8.0, 6.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Edit profile',
                                              style:
                                                  FlutterFlowTheme.of(context)
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
                              if (valueOrDefault<bool>(
                                  currentUserDocument?.enableEmail, false))
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 0.0, 0.0, 0.0),
                                    child: AuthUserStreamWidget(
                                      builder: (context) => InkWell(
                                        onTap: () async {
                                          await launchUrl(Uri(
                                            scheme: 'mailto',
                                            path: currentUserEmail,
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
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8.0, 6.0, 8.0, 6.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Email',
                                                    style: FlutterFlowTheme.of(
                                                            context)
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
                              length: 3,
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
                                      Tab(
                                        icon: Icon(
                                          FFIcons.kbookmark,
                                          size: 26.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                      children: [
                                        KeepAliveWidgetWrapper(
                                          builder: (context) =>
                                              StreamBuilder<List<PostsRecord>>(
                                            stream: queryPostsRecord(
                                              queryBuilder: (postsRecord) =>
                                                  postsRecord
                                                      .where('post_user',
                                                          isEqualTo:
                                                              currentUserReference)
                                                      .where('deleted',
                                                          isEqualTo: false)
                                                      .orderBy('time_posted',
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
                                                scrollDirection: Axis.vertical,
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
                                              StreamBuilder<List<PostsRecord>>(
                                            stream: queryPostsRecord(
                                              queryBuilder: (postsRecord) =>
                                                  postsRecord
                                                      .where('tagged_users',
                                                          arrayContains:
                                                              currentUserReference)
                                                      .where('deleted',
                                                          isEqualTo: false)
                                                      .orderBy('time_posted',
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
                                                scrollDirection: Axis.vertical,
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
                                        KeepAliveWidgetWrapper(
                                          builder: (context) => StreamBuilder<
                                              List<BookmarksRecord>>(
                                            stream: queryBookmarksRecord(
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
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                );
                                              }
                                              List<BookmarksRecord>
                                                  bookmarkedPhotosBookmarksRecordList =
                                                  snapshot.data!;
                                              // Return an empty Container when the item does not exist.
                                              if (snapshot.data!.isEmpty) {
                                                return Container();
                                              }
                                              final bookmarkedPhotosBookmarksRecord =
                                                  bookmarkedPhotosBookmarksRecordList
                                                          .isNotEmpty
                                                      ? bookmarkedPhotosBookmarksRecordList
                                                          .first
                                                      : null;
                                              return Builder(
                                                builder: (context) {
                                                  final bookmarkedposts =
                                                      bookmarkedPhotosBookmarksRecord!
                                                          .postRefs!
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
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount:
                                                        bookmarkedposts.length,
                                                    itemBuilder: (context,
                                                        bookmarkedpostsIndex) {
                                                      final bookmarkedpostsItem =
                                                          bookmarkedposts[
                                                              bookmarkedpostsIndex];
                                                      return StreamBuilder<
                                                          PostsRecord>(
                                                        stream: PostsRecord
                                                            .getDocument(
                                                                bookmarkedpostsItem),
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
                                                          final photoPostsRecord =
                                                              snapshot.data!;
                                                          return InkWell(
                                                            onTap: () async {
                                                              context.pushNamed(
                                                                'PostDetails',
                                                                queryParams: {
                                                                  'post':
                                                                      serializeParam(
                                                                    bookmarkedpostsItem,
                                                                    ParamType
                                                                        .DocumentReference,
                                                                  ),
                                                                }.withoutNulls,
                                                              );
                                                            },
                                                            child:
                                                                Image.network(
                                                              photoPostsRecord
                                                                  .postPhoto!,
                                                              width: 100.0,
                                                              height: 100.0,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
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
                                                  color: Colors.black,
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
