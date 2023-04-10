import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sign_up_username_confirmation_model.dart';
export 'sign_up_username_confirmation_model.dart';

class SignUpUsernameConfirmationWidget extends StatefulWidget {
  const SignUpUsernameConfirmationWidget({Key? key}) : super(key: key);

  @override
  _SignUpUsernameConfirmationWidgetState createState() =>
      _SignUpUsernameConfirmationWidgetState();
}

class _SignUpUsernameConfirmationWidgetState
    extends State<SignUpUsernameConfirmationWidget> {
  late SignUpUsernameConfirmationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignUpUsernameConfirmationModel());

    _model.emailHIDDENController ??=
        TextEditingController(text: FFAppState().signupEmail);
    _model.passwordHIDDENController ??=
        TextEditingController(text: FFAppState().signupPassword);
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
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 58.0, 0.0, 0.0),
                              child: Text(
                                'Cadastrar como',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .title1
                                    .override(
                                      fontFamily: 'Inter',
                                      lineHeight: 1.5,
                                    ),
                              ),
                            ),
                            Text(
                              '${FFAppState().signupUsername}?',
                              textAlign: TextAlign.center,
                              style:
                                  FlutterFlowTheme.of(context).title1.override(
                                        fontFamily: 'Inter',
                                        lineHeight: 1.5,
                                      ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  40.0, 18.0, 40.0, 0.0),
                              child: Text(
                                'Você poderá mudar seu nome de usuário depois. ',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText2
                                    .override(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.normal,
                                      lineHeight: 1.5,
                                    ),
                              ),
                            ),
                            TextFormField(
                              controller: _model.emailHIDDENController,
                              readOnly: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Inter',
                                    color: Colors.white,
                                    fontSize: 0.0,
                                  ),
                              validator: _model.emailHIDDENControllerValidator
                                  .asValidator(context),
                            ),
                            TextFormField(
                              controller: _model.passwordHIDDENController,
                              readOnly: true,
                              obscureText: !_model.passwordHIDDENVisibility,
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                suffixIcon: InkWell(
                                  onTap: () => setState(
                                    () => _model.passwordHIDDENVisibility =
                                        !_model.passwordHIDDENVisibility,
                                  ),
                                  focusNode: FocusNode(skipTraversal: true),
                                  child: Icon(
                                    _model.passwordHIDDENVisibility
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: Colors.white,
                                    size: 0.0,
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Inter',
                                    color: Colors.white,
                                    fontSize: 0.0,
                                  ),
                              validator: _model
                                  .passwordHIDDENControllerValidator
                                  .asValidator(context),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            40.0, 12.0, 40.0, 24.0),
                        child: Text(
                          'Ao tocar em Cadastre-se, você concorda com nossos Termos, Política de Privacidade e Política de Cookies.',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyText2.override(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.normal,
                                    lineHeight: 1.5,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 0.5,
                  decoration: BoxDecoration(
                    color: Color(0xFFDADADA),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(40.0, 12.0, 40.0, 0.0),
                      child: FutureBuilder<List<AdministrativeRecord>>(
                        future: queryAdministrativeRecordOnce(
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
                          List<AdministrativeRecord>
                              signUpButtonAdministrativeRecordList =
                              snapshot.data!;
                          final signUpButtonAdministrativeRecord =
                              signUpButtonAdministrativeRecordList.isNotEmpty
                                  ? signUpButtonAdministrativeRecordList.first
                                  : null;
                          return FFButtonWidget(
                            onPressed: () async {
                              GoRouter.of(context).prepareAuthEvent();

                              final user = await createAccountWithEmail(
                                context,
                                _model.emailHIDDENController.text,
                                _model.passwordHIDDENController.text,
                              );
                              if (user == null) {
                                return;
                              }

                              final usersCreateData = {
                                ...createUsersRecordData(
                                  email: FFAppState().signupEmail,
                                  displayName: FFAppState().signupName,
                                  photoUrl:
                                      'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg',
                                  username: FFAppState().signupUsername,
                                  birthday: FFAppState().signupBirthday,
                                  createdTime: getCurrentTimestamp,
                                  bio: '',
                                  website: '',
                                  enableEmail: false,
                                ),
                                'following': FFAppState().emptyList,
                              };
                              await UsersRecord.collection
                                  .doc(user.uid)
                                  .update(usersCreateData);

                              final administrativeUpdateData = {
                                'usernames': FieldValue.arrayUnion(
                                    [FFAppState().signupUsername]),
                              };
                              await signUpButtonAdministrativeRecord!.reference
                                  .update(administrativeUpdateData);

                              final followersCreateData = {
                                'userRefs': FFAppState().emptyList,
                              };
                              await FollowersRecord.createDoc(
                                      currentUserReference!)
                                  .set(followersCreateData);

                              final bookmarksCreateData =
                                  createBookmarksRecordData();
                              await BookmarksRecord.createDoc(
                                      currentUserReference!)
                                  .set(bookmarksCreateData);

                              context.goNamedAuth('Feed', mounted);
                            },
                            text: 'Cadastrar',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 50.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color:
                                  FlutterFlowTheme.of(context).secondaryColor,
                              textStyle: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: 'Inter',
                                    color: Colors.white,
                                    fontSize: 14.0,
                                  ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          24.0, 24.0, 24.0, 24.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Você já possuí uma conta?',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Inter',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                3.0, 0.0, 0.0, 0.0),
                            child: InkWell(
                              onTap: () async {
                                context.goNamed(
                                  'SignIn',
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: TransitionInfo(
                                      hasTransition: true,
                                      transitionType:
                                          PageTransitionType.leftToRight,
                                    ),
                                  },
                                );
                              },
                              child: Text(
                                'Login',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Inter',
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
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
      ),
    );
  }
}
